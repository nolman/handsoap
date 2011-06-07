# -*- coding: utf-8 -*-
require 'test_helper'

class TestService < Handsoap::Service
  endpoint :uri => 'http://127.0.0.1:8088/mocksc002SOAP11Binding', :version => 1
  map_method :begin => "sc002:Begin"
  map_method :notify => "sc002:Notify"
  map_method :echo => "sc002:Echo"
  def on_create_document(doc)
    doc.alias 'sc002', "http://www.wstf.org/docs/scenarios/sc002"
    doc.find("Header").add "sc002:SessionData" do |session_data|
      session_data.add "ID", "Client-1"
    end
  end
  def on_missing_document(http_response_body)
    # pass
  end
end

Handsoap::Service.logger = $stdout

s = TestService.new

s.begin

s.notify do |x|
  x.add "text", "Hello"
end

s.echo do |x|
  x.add "text", "Hello"
end

