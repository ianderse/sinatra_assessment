require 'sequel'
require 'sqlite3'

Database = Sequel.sqlite("db/#{ENV['RACK_ENV']}.sqlite3")

class Page
  def self.create(data)
    Page.new(data).save!
  end

  def self.find_by_slug(slug)
    data = table.where(:slug => slug).first
    Page.new(data) if data
  end

  def self.table
    Database.from(:pages)
  end

  def self.all
    table.select.map{|p| Page.new(p)}
  end

  def self.destroy(slug)
    table.where(:slug => slug).delete
  end

  def self.update(slug, params)
    table.where(:slug => slug).update(:slug => params[:slug], :content => params[:content])
  end

  attr_reader :slug, :content

  def initialize(data)
    @slug = data[:slug]
    @content = data[:content]
  end

  def save!
    self if table.insert(:slug => slug, :content => content)
  end

  def table
    self.class.table
  end

  def ==(other)
    slug == other.slug && content == other.content
  end
end
