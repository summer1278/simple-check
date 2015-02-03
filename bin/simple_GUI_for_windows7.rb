#$: << "lib"
require "tk"
# encoding: UTF-8

#module Checker
class SimpleGUI
 def initialize
   $dir_name1 = TkVariable.new
   $dir_name2 = TkVariable.new
   $dir_name3 = TkVariable.new
   select1 = proc {p_select1}
   select2 = proc {p_select2}
   select3 = proc {p_select3}
   collect = proc {p_collect}
   root = TkRoot.new {
    title "Simple Checker Demo"
  }
  @inputText1 = TkLabel.new(root) {
    text "Source:"
    width 8
    height 1
    grid("row"=>0, "column"=>0)
  }
  @inputField1 = TkEntry.new(root) {
    textvariable $dir_name1
    width 60
    grid("row"=>0, "column"=>1)
  }
  @browseButton1 = TkButton.new(root) {
    text "browse.."
    command select1
    grid("row"=>0, "column"=>2)
  }
  @inputText2 = TkLabel.new(root) {
    text "Translation:"
    width 8
    height 1
    grid("row"=>1, "column"=>0)
  }
  @inputField2 = TkEntry.new(root) {
    textvariable $dir_name2
    width 60
    grid("row"=>1, "column"=>1)
  }
  @browseButton2 = TkButton.new(root) {
    text "browse.."
    command select2
    grid("row"=>1, "column"=>2)
  }
  @inputText3 = TkLabel.new(root) {
    text "Output:"
    width 8
    height 1
    grid("row"=>2, "column"=>0)
  }
  @inputField3 = TkEntry.new(root) {
    textvariable $dir_name3
    width 60
    grid("row"=>2, "column"=>1)
  }
  @browseButton3 = TkButton.new(root) {
    text "browse.."
    command select3
    grid("row"=>2, "column"=>2)
  }
  @SubmitButton = TkButton.new(root) {
    text "Submit"
    command collect
    grid("row"=>3, "column"=>0, "columnspan"=>3)
  }
  @inputText1 = TkLabel.new(root) {
    text "*Ensure your input txt files are UTF-8 encoded!"
    height 1
    grid("row"=>4, "column"=>0,"columnspan"=>3)
  }
end

def p_select1
  begin
   $dir_name1.value = Tk.chooseDirectory
 rescue
   $dir_name1.value = ""
 end
end

def p_select2
  begin
   $dir_name2.value = Tk.chooseDirectory
 rescue
   $dir_name2.value = ""
 end
end

def p_select3
  begin
   $dir_name3.value = Tk.chooseDirectory
 rescue
   $dir_name3.value = ""
 end
end

def p_collect
 if $dir_name1.value.empty? || $dir_name2.value.empty? || $dir_name3.value.empty? then
  Tk.messageBox("icon"=>"error", "title"=>"Error!", 
   "message"=>"Plz make sure all the directory have been filled in!")
else
        #config.eager_autoload_paths += %W(#{config.root}/lib)
        check = Checker::SimpleCollecter.new($dir_name1.value, $dir_name2.value, $dir_name3.value)
        check.collect
        Tk.messageBox("title"=> "OK!", 
          "message"=>"Grouped csv has been created.")
      end
    end

  end

  require "csv"

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
     src = collect_dir(@source_dir,0)
     trs = collect_dir(@translation_dir,1)
     CSV.open(@result_dir+"/data.csv", "w:utf-8") do |csv_file|
       head = "\xEF\xBB\xBF".force_encoding("utf-8")
       csv_file << [head,nil,nil,nil]
       src.each_with_index {|row,i| csv_file<<row.insert(2,trs[i][1])}
     end

   end

   def collect_dir (source,other)

    sentences = [] 
    data = Array.new(3,nil)
    Dir.glob( source +"/*.txt") do |doc_file|
	  	#data = Array.new(3,nil)
	  	data[2] = File.basename(doc_file)
      file = File.open(doc_file, "r:utf-8")
      lines = file.readlines

      if lines != nil
        if !lines.any? { |s| s.include?("\\n\n") }
          lines.each do |line|
            data[0] = "Option"
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
				        # if it is translation, check
				        if (other == 1)
                  if not_chn(data[1])
                  data[1] = data[1]+'JPN'
                  end
                  if sentences_check(data[1])
                    data[1] = data[1]+'CHECK1'
                  end
                  if chars_check(data[1].gsub("JPN",""))
                    data[1] = data[1]+'CHECK2'
                  end
               end
        sentences << [data[0],data[1],data[2]]
      end
    end
  end
end

end
return sentences
    #CSV.open("test/data.csv", "w") do |csv_file|
    #  sentences.each {|row| csv_file<<row}
    #end

  end

  def remove_symbols(string)
    string.gsub("\r\n","").gsub("\\n","\n").strip
  end
  
  # search for jpn characters
  def not_chn(source)
  	utf_source = source.encode('UTF-8')
    !utf_source.scan(/\p{Katakana}|\p{Hiragana}/u).empty?
  end
  
  # less than 3 lines
  def sentences_check(source)
    source.lines.count > 3
  end
  
  # each line less than 22 characters
  def chars_check(source)
    chars_count = []
    source.lines.each {|line| chars_count << line.gsub("\n","").size}
    !chars_count.select{|count| count>22}.empty?
  end

end
end

SimpleGUI.new

if not defined?(Ocra)
  Tk.mainloop
end

 #end