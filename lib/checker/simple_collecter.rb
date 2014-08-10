require 'csv'
require 'pp'
# coding:utf-8
module Checker

  class SimpleCollecter
   def initialize ( source_dir, translation_dir, result_dir)
    @source_dir = source_dir
    @translation_dir = translation_dir
    @result_dir = result_dir
  end

  def collect
    group_source_and_translation
  end

  def group_source_and_translation
   src = collect_dir(@source_dir)
   trs = collect_dir(@translation_dir)
   CSV.open('test/data.csv', 'w') do |csv_file|
    src.each_with_index {|row,i| csv_file<<row.insert(2,trs[i][1])}
   end
 end

 def collect_dir (source)

  sentences = [] 
  data = Array.new(3,nil)
  Dir.glob( source +'/*.txt') do |doc_file|
	  	#data = Array.new(3,nil)
	  	data[2] = File.basename(doc_file)
      file = File.open(doc_file, 'r')
      lines = file.readlines

      if lines != nil
        if !lines.any? { |s| s.include?("\n") }
          lines.each do |line|
            data[0] = 'Option'
            data[1] = remove_symbols(line)
            sentences << [data[0],data[1],data[2]]
          end
        else
          lines.each_with_index do |line, index|
            if index % 2 == 0
              data[0] = remove_symbols(line)
                #p data[0]
              else
                data[1] = remove_symbols(line)
                #p data
                sentences << [data[0],data[1],data[2]]
              end
            end
          end
        end
        
      end
      return sentences
    #CSV.open('test/data.csv', 'w') do |csv_file|
    #  sentences.each {|row| csv_file<<row}
    #end

  end

  def remove_symbols(string)
    string.gsub('/\r?\n/','').gsub("\\n","\n").strip
  end


end
end
