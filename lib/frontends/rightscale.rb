module Frontends

  class RightScale

    require 'rest_connection'

    def initialize(opts)
      ENV['REST_CONNECTION_LOG'] = opts[:log] if opts[:log]
      @nickname = opts[:nickname]
      @deployment = opts[:deployment]
      @array = opts[:array]
    end

    def instances
      if @deployment and @nickname
        # Searching instances from deployment is slow so we fetch all matching servers and filter them afterwards
        servers = Server.find_by(:nickname) { |n| n =~ /^#{@nickname}[0-9]+/ }
      
        # Only return operational and booting instances
        operational = servers.select { |s| s['state'] == 'operational' or s['state'] == 'booting'}

        # Ip-addresses etc. is stored in server.settings
        instances = operational.map { |i| Server.find(i['href']).settings }
      
        # Filter results with deployment id
        deployment = instances.select { |i| i["deployment_href"].split('/').last == @deployment }
      
        # Unify resultset
        deployment.map { |instance| { :nickname => sanitize_nickname(instance['nickname']), :private_ip_address => instance['private-ip-address'] } }
      elsif @array
        array = Ec2ServerArray.find(@array.to_i)

        # Only return operational and booting instances
        instances = array.instances.select {|i| i['state'] == 'operational' or i['state'] == 'booting' }

        # Unify & sanitize resultset
        instances.map { |instance| { :nickname => sanitize_nickname(instance['nickname']), :private_ip_address => instance['private_ip_address'] } }
      else
        fail "No server array or deployment & nickname filters were given"
      end
    end
    
    private

    def sanitize_nickname(nickname)
      # Simple sanitization
      nickname.tr_s('# ', '_')
    end

  end

end