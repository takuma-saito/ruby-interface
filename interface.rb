
# インターフェイスを定義するクラス

module Interface
  class InterfaceError < Exception; end

  # クラス拡張
  def self.included(c)
    c.extend ClassMethod
  end

  module ClassMethod

    # インターフェイスを定義
    def interface(*methods)
      @methods = methods
      @sub_class = []
    end

    # オートロード機能を無効にする
    def disable_autoload
      Kernel.class_eval do 
        alias autoload_old autoload
        define_method(:autoload) do |c, file|
          require_relative file
        end
      end
    end

    # 継承時インターフェイスが定義されているか確認する
    def inherited(c)
      @sub_class << c
    end

    # 全てのサブクラスがインターフェイスを実装しているかテスト
    def interface_assert
      @sub_class.each do |c|
        undefined = []
        methods = c.instance_methods(false)
        @methods.each do |method|
          undefined << method unless methods.include? method
        end
        unless undefined.empty?
          raise InterfaceError, "class: #{c.name}, undefined method: #{undefined.join(', ')}" 
        end
      end
    end

  end
end
