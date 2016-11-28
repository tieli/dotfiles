#!/usr/bin/env ruby
require 'irb/completion'
require 'irb/ext/save-history'
require 'awesome_print'

IRB.conf[:PROMPT_MODE] = :SIMPLE
IRB.conf[:SAVE_HISTORY] = 1000
IRB.conf[:HISTORY_FILE] = "#{ENV['HOME']}/.irb_history"
IRB.conf[:AUTO_INDENT_MODE] = false

#ActiveRecord::Base.Logger.level =1 if defined? ActiveRecord::Base

def y(obj)
  puts obj.to_yaml
end

if defined? Rails
  begin
    require 'hirb'
    Hirb.enable
  rescue LoadError
  end
end
