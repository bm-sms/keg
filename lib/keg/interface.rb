require 'keg'

module Keg
  class Interface
    def initialize(root)
      @database = Database.new(root)
    end

    def switch(name)
      @database.use(name)
    end

    def show(filename, format)
      contents = @database.select(filename)
      formatter = Formatter.create(format)
      formatter.format(contents)
    end

    def current
      @database.current
    end

    def each(format)
      formatter = Formatter.create(format)
      @database.select_all.each do |contents|
        yield formatter.format(contents)
      end
    end
  end
end