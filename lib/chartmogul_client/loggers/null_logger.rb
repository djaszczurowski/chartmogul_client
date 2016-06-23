module ChartmogulClient::Loggers
  class NullLogger
    def debug(message, &block)
    end

    def error(message, &block)
    end

    def fatal(message, &block)
    end

    def info(message, &block)
    end

    def log(message, &block)
    end

    def unknown(message, &block)
    end

    def warn(message, &block)
    end
  end
end