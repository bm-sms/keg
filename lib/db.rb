module DB
  def self.switch(name)
    @path = "#{ENV["HOME"]}/.yet_another_glean/#{name}"
    @db_name = name
    File.exists?(@path)
  end

  def self.get_file(filename)
    begin
      @db = File.open("#{@path}/#{filename}.toml")
    rescue
      false
    end
  end

  def self.close
    @db.close
  end
end