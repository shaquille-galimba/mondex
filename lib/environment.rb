require_relative "mondex/version"
require_relative "mondex/cli"
require_relative "mondex/scraper"
require_relative "mondex/monster"
require_relative "mondex/species"

require 'nokogiri'
require 'pry'

module Mondex
  class Error < StandardError; end
  # Your code goes here...
end
