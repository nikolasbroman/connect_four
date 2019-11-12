require "./lib/connect_four.rb"

RSpec.describe ConnectFour do

  describe "#grid" do
    it "returns grid as an array" do
      cf = ConnectFour.new
      expect(cf.grid).to be_an_instance_of(Array)
    end


    it "the grid is empty and of size 6 x 7 (W x H)" do
      cf = ConnectFour.new
      ary = [
        [" ", " ", " ", " ", " ", " ", " "],
        [" ", " ", " ", " ", " ", " ", " "],
        [" ", " ", " ", " ", " ", " ", " "],
        [" ", " ", " ", " ", " ", " ", " "],
        [" ", " ", " ", " ", " ", " ", " "],
        [" ", " ", " ", " ", " ", " ", " "]
      ]
      expect(cf.grid).to eql(ary)
    end
  end

  describe "#insert_into_position" do
    it "inserts an x into a position" do
      cf = ConnectFour.new
      cf.insert_into_position(5, 2, "x")
      expect(cf.grid[5][2]).to eql("x")
    end
  end

  describe "#drop_into_column" do
    it "reaches row 5, if grid is empty" do
      cf = ConnectFour.new
      cf.drop_into_column(3, "x")
      expect(cf.grid[5][3]).to eql("x")
    end

    it "reaches row 4, if row 5 is occupied" do
      cf = ConnectFour.new
      cf.insert_into_position(5, 3, "x")
      cf.drop_into_column(3, "x")
      expect(cf.grid[4][3]).to eql("x")
    end

    it "returns nil if that column is full" do
      cf = ConnectFour.new
      cf.insert_into_position(5, 3, "x")
      cf.insert_into_position(4, 3, "x")
      cf.insert_into_position(3, 3, "x")
      cf.insert_into_position(2, 3, "x")
      cf.insert_into_position(1, 3, "x")
      cf.insert_into_position(0, 3, "x")
      result = cf.drop_into_column(3, "x")
      expect(result).to eql(nil)
    end
  end

  describe "#check_victory" do
    it "#returns nil if no one has won yet" do
      cf = ConnectFour.new
      cf.grid = [
        [" ", " ", " ", " ", " ", " ", " "],
        [" ", " ", " ", " ", " ", " ", " "],
        [" ", " ", " ", " ", "o", " ", " "],
        [" ", " ", " ", "o", "x", " ", " "],
        [" ", " ", "o", "x", "x", "x", " "],
        [" ", "x", "x", "o", "o", "o", " "]
      ]
      expect(cf.check_victory).to eql(nil)
    end
    it "#returns winner if 4 in a row" do
      cf = ConnectFour.new
      cf.grid = [
        [" ", " ", " ", " ", " ", " ", " "],
        [" ", " ", " ", " ", " ", " ", " "],
        [" ", " ", " ", " ", "o", " ", " "],
        [" ", " ", " ", "o", "x", " ", " "],
        [" ", " ", "o", "x", "x", "x", " "],
        [" ", "x", "x", "o", "o", "o", "o"]
      ]
      expect(cf.check_victory).to eql("o")
    end
    it "#returns winner if 4 in a column" do
      cf = ConnectFour.new
      cf.grid = [
        [" ", " ", " ", " ", " ", " ", " "],
        [" ", " ", " ", " ", "x", " ", " "],
        [" ", " ", " ", " ", "x", " ", " "],
        [" ", " ", " ", "o", "x", " ", " "],
        [" ", " ", "o", "x", "x", "o", " "],
        [" ", "x", "x", "o", "o", "o", " "]
      ]
      expect(cf.check_victory).to eql("x")
    end
    it "#returns winner if 4 diagonally downwards" do
      cf = ConnectFour.new
      cf.grid = [
        [" ", " ", " ", " ", " ", " ", " "],
        [" ", " ", " ", " ", " ", " ", " "],
        [" ", "x", " ", " ", " ", " ", " "],
        [" ", "o", "x", "o", "o", " ", " "],
        [" ", "x", "o", "x", "x", " ", " "],
        [" ", "o", "x", "o", "x", "o", " "]
      ]
      expect(cf.check_victory).to eql("x")
    end
    it "#returns winner if 4 diagonally upwards" do
      cf = ConnectFour.new
      cf.grid = [
        [" ", " ", " ", " ", " ", " ", " "],
        [" ", " ", " ", " ", " ", " ", " "],
        [" ", " ", " ", " ", "o", "x", " "],
        [" ", " ", " ", "o", "x", "o", " "],
        [" ", " ", "o", "x", "x", "x", " "],
        [" ", "x", "x", "o", "o", "o", " "]
      ]
      expect(cf.check_victory).to eql("x")
    end
  end

  describe "#get_column_from_player" do
    it "should return integer 3 when inputting string 4" do
      cf = ConnectFour.new
      column = cf.get_column_from_player
      expect(column).to eql(3)
    end
  end

  describe "#column_full?" do
    cf = ConnectFour.new
    cf.grid = [
      [" ", " ", " ", " ", "o", " ", " "],
      [" ", " ", " ", " ", "x", " ", " "],
      [" ", " ", " ", " ", "o", "o", " "],
      [" ", " ", " ", "o", "x", "o", " "],
      [" ", " ", "o", "x", "x", "x", " "],
      [" ", "x", "x", "o", "o", "o", " "]
    ]
    it "return true if column is full already" do
      expect(cf.column_full?(4)).to eql(true)
    end
    it "return false if column is not yet full" do
      expect(cf.column_full?(3)).to eql(false)
    end
  end

  describe "#grid_to_s" do
    it "works" do
      cf = ConnectFour.new
      cf.grid = [
        [" ", " ", " ", " ", "o", " ", " "],
        [" ", " ", " ", " ", "x", " ", " "],
        [" ", " ", " ", " ", "o", "o", " "],
        [" ", " ", " ", "o", "x", "o", " "],
        [" ", " ", "o", "x", "x", "x", " "],
        ["o", "x", "x", "o", "o", "o", "x"]
      ]
      string = ""
      string += "  1 2 3 4 5 6 7  \n"
      string += "|         o     |\n"
      string += "|         x     |\n"
      string += "|         o o   |\n"
      string += "|       o x o   |\n"
      string += "|     o x x x   |\n"
      string += "| o x x o o o x |\n"
      
      expect(cf.grid_to_s).to eql(string)      
    end
  end

end