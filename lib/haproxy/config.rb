module Haproxy

  class Config
    
    def initialize(opts)
      @opts = opts
      @config = File.expand_path(@opts[:config]) if opts[:config]
      @template = File.expand_path(@opts[:template])
      @instances = Frontends::RightScale.new(@opts).instances
      fail "No matching frontends could be found, extiting" if @instances.size == 0
    end
    
    def print()
      puts parse_config
    end
    
    def write()
      @cfg = parse_config
      if up_to_date?
        puts "Config unchanged"
        exit(0)
      else
        backup_config_file
        write_config_file
      end
    end

    private
    
    def parse_config()
      template = ERB.new(File.read(@template), nil, '<%>')
      result = template.result(binding)
    end
    
    def write_config_file()
      begin
        dir = File.split(@config)[0]
        Dir::mkdir(dir) unless File.exists?(dir)
        File.open(@config, 'w') {|f| f.write(@cfg) }
        puts "Wrote #{@config}"
      rescue Errno::EACCES
        abort "Could not write #{@config}: #{$!}"
      end
    end
    
    def backup_config_file()
      if File.exists?(@config)
        backup = @config + '.bak.' + "#{Time.now.utc.strftime('%Y%m%d%H%M%S')}"
        File.rename(@config, backup)
        puts "Backup #{backup} created"
      end
    end

    def up_to_date?()
      if File.exists?(@config)
        @cfg == File.read(@config)
      else
        return false
      end
    end

  end
      
end