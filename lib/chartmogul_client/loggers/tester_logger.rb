module ChartmogulClient::Loggers
  class TesterLogger
    def debug(message, &block)
      puts message
    end

    def error(message, &block)
      puts message
    end

    def fatal(message, &block)
      puts message
    end

    def info(message, &block)
      puts message
    end

    def log(message, &block)
      puts message
    end

    def unknown(message, &block)
      puts message
    end

    def warn(message, &block)
      puts message
    end
  end
end