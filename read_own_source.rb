
def read_self
  #$0 is the name of the file used to start the program
  file = File.open($0, "r")
  #iterates over each line and puts
    file.readlines.each do |line|
      puts line
    end
end

read_self
