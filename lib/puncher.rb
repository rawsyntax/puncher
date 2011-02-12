begin
  require 'fsevent'
rescue LoadError
  require 'rubygems'
  require 'fsevent'
end

class Puncher < FSEvent

  def initialize(command, files)
    @command, @files, @latency, @last_sec = command, files, 0.2, Time.now

    start
  end

  def start
    watch_directories((@files.collect { |f| File.dirname(f) }).uniq)
    super
  end

  def on_change(directories)
    time = @last_sec

    @files.each { |f| @last_sec = File.mtime(f) if File.mtime(f) > @last_sec }

    system @command unless time == @last_sec
  end

end
