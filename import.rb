require 'json'
require 'RMagick'

STATUS_FREE = "red=65535, green=65535, blue=65535, opacity=0"
STATUS_CHECKED = "red=0, green=0, blue=0, opacity=0"
STATUS_UNCHECKED = "red=26214, green=26214, blue=26214, opacity=0"
STATUS_DISABLED = "red=52428, green=52428, blue=52428, opacity=0"

@data = {}
3.times do |t|
  img = Magick::Image::read("man#{t+1}.gif").first
  
  @hash = []
  img.each_pixel do |pixel, c, r|
    line = (r/16).to_i
    cell = (c/16).to_i
    
    @hash[line] = {
      :start => nil,
      :items => []
    } if !@hash[line]
    
    if !@hash[line][:start] && pixel.to_s != STATUS_FREE
      @hash[line][:start] = {
        :c => c,
        :r => r
      } 
    end
    @hash[line][:items][cell] = "" if !@hash[line][:items][cell] && pixel.to_s == STATUS_FREE
  
    if @hash[line][:start] && c == @hash[line][:start][:c]+1 && r == @hash[line][:start][:r]+1
      case pixel.to_s
        when STATUS_FREE
        begin 
          @hash[line][:items][cell] = ""
        end

        when STATUS_CHECKED
        begin
          @hash[line][:items][cell] = 1
        end
  
        when STATUS_UNCHECKED
        begin
          @hash[line][:items][cell] = 0
        end

        when STATUS_DISABLED
        begin
          @hash[line][:items][cell] = -1
        end
  
        else
          puts line, pixel, c, r
      end
  
      @hash[line][:start][:c] += 16
    end
    
    #exit if line == 9
  end
  
  @data[t] = @hash
end

File.open("boxes.js", "w") do |f|
  f.write "var BOXES = #{@data.to_json}"
end
