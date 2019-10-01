# encoding: UTF-8
require 'uri'
require 'net/http'
require 'net/https'

class SemanticWordsService
  def initialize
    @base_url  = ENV['SEMANTIC_URL']
    @username  = ENV['SEMANTIC_USERNAME']
    @password  = ENV['SEMANTIC_PASSWORD']
  end

  def login
    base_url = "#{@base_url}/api/login/"
    uri = URI(base_url)

    req = Net::HTTP::Post.new(uri)
    data = { "username" => "#{@username}", "password"=>"#{@password}"}
    req.set_form_data(data)

    begin
      response = Net::HTTP.start(uri.hostname, uri.port, :use_ssl =>uri.scheme == 'https') {|http|
        http.request(req)
      }

      error = false
    rescue
      error = true
    end

    data = if error == false && response.code == '200'
              resp = JSON.parse(response.body)
            else
              error = true
           end

    { data: data, error: error }
  end

  def find_similar(word, count)
    response = login
    return { data: 'Не верный логин/пароль', error: true } if response[:error]

    base_url = "#{@base_url}/api/find_similar/"
    uri = URI(base_url)

    req = Net::HTTP::Post.new(uri)
    req['Authorization'] = "Token #{response[:data]['token']}"

    data = { "word" => "#{word}", "count"=>"#{count}"}
    req.set_form_data(data)

    begin
      response = Net::HTTP.start(uri.hostname, uri.port, :use_ssl =>uri.scheme == 'https') {|http|
        http.request(req)
      }

      error = false
    rescue
      error = true
    end

    data = if error == false && response.code == '200'
              resp = JSON.parse(response.body)
            else
              error = true
           end

    { data: data, error: error }
  end
end