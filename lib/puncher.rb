begin
  require 'fsevent'
rescue LoadError
  require 'rubygems'
  require 'fsevent'
end

class Puncher < FSEvent

  def initialize(command, files)
    @command, @files, @latency, @last_time = command, files, 0.2, Time.now

    start
  end

  def start
    dirs = []

    @files.each do |f|
      dirs << File.dirname(f)
    end

    watch_directories(dirs.uniq)
    super
  end

  def on_change(directories)
    time = @last_time

    @files.each do |f|
      if File.mtime(f) > @last_time
        @last_time = File.mtime(f)
      end
    end

    system @command unless time == @last_time
  end
end
