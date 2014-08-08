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
	  	collect_source
    end
    
    def group_both
    	
    end

    def collect_source
    
      sentences = [] 
	  Dir.glob( @source_dir +'/*.txt') do |doc_file|
	  	data = []
	  	data[2] = File.basename(doc_file)
        lines = File.readlines(doc_file)
        if lines != nil
          lines.each_with_index do |line, index|
            if index%2 == 0
           	  data[0] = line
            else
          	  data[1] = line
          	  sentences << data
            end
          end
        end
        pp sentences
     end

    end

	def collect_translation

	end


  end
end
