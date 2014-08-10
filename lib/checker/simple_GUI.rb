$: << 'lib'
require 'tk'
require 'checker'

module Checker
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
  	  	title 'Simple Checker Demo'
  	  }
  	  @inputText1 = TkLabel.new(root) {
  	  	text 'Source:'
  	  	width 8
  	  	height 1
  	  	grid('row'=>0, 'column'=>0)
  	  }
  	  @inputField1 = TkEntry.new(root) {
  	  	textvariable $dir_name1
  	  	width 60
  	  	grid('row'=>0, 'column'=>1)
  	  }
  	  @browseButton1 = TkButton.new(root) {
  	  	text 'browse..'
  	  	command select1
  	  	grid('row'=>0, 'column'=>2)
  	  }
  	  @inputText2 = TkLabel.new(root) {
  	  	text 'Translation:'
  	  	width 8
  	  	height 1
  	  	grid('row'=>1, 'column'=>0)
  	  }
  	  @inputField2 = TkEntry.new(root) {
  	  	textvariable $dir_name2
  	  	width 60
  	  	grid('row'=>1, 'column'=>1)
  	  }
  	  @browseButton2 = TkButton.new(root) {
  	  	text 'browse..'
  	  	command select2
  	  	grid('row'=>1, 'column'=>2)
  	  }
  	  @inputText3 = TkLabel.new(root) {
  	  	text 'Output:'
  	  	width 8
  	  	height 1
  	  	grid('row'=>2, 'column'=>0)
  	  }
  	  @inputField3 = TkEntry.new(root) {
  	  	textvariable $dir_name3
  	  	width 60
  	  	grid('row'=>2, 'column'=>1)
  	  }
  	  @browseButton3 = TkButton.new(root) {
  	  	text 'browse..'
  	  	command select3
  	  	grid('row'=>2, 'column'=>2)
  	  }
  	  @SubmitButton = TkButton.new(root) {
  	  	text 'Submit'
  	  	command collect
  	  	grid('row'=>3, 'column'=>0, 'columnspan'=>3)
  	  }
      @inputText1 = TkLabel.new(root) {
        text '*Ensure your input txt files are UTF-8 encoded!'
        height 1
        grid('row'=>4, 'column'=>0,'columnspan'=>3)
      }
  	end

  	def p_select1
      begin
      	$dir_name1.value = Tk.chooseDirectory
      rescue
      	$dir_name1.value = ''
      end
  	end

  	def p_select2
      begin
      	$dir_name2.value = Tk.chooseDirectory
      rescue
      	$dir_name2.value = ''
      end
  	end

  	def p_select3
      begin
      	$dir_name3.value = Tk.chooseDirectory
      rescue
      	$dir_name3.value = ''
      end
  	end

  	def p_collect
  	  if $dir_name1.value.empty? || $dir_name2.value.empty? || $dir_name3.value.empty? then
  	  	Tk.messageBox('icon'=>'error', 'title'=>'Error!', 
  	  		'message'=>'Plz make sure all the directory have been filled in!')
  	  else
        #config.eager_autoload_paths += %W(#{config.root}/lib)
  	  	check = Checker::SimpleCollecter.new($dir_name1.value, $dir_name2.value, $dir_name3.value)
  	    check.collect
        Tk.messageBox('title'=> 'OK!', 
          'message'=>'Grouped csv has been created.')
  	  end
  	end

  end
  SimpleGUI.new
  Tk.mainloop
 end