require '../lib/connect_four.rb'

RSpec.configure do |rspec|
  rspec.deprecation_stream = 'log/rspec-deprecations.log'
  rspec.failure_color = :yellow
  rspec.tty = true
  rspec.color = true
end

describe ConnectFour do 
	context "a new instance of the game" do

		it "creates the board object" do
			expect(subject.board).to be_a Board 	
		end

		it "creates two players" do
			expect(subject.player1).to be_a Player
			expect(subject.player2).to be_a Player
		end
	end
end

describe Player do 
	let(:player1) {Player.new("Krzysiek","X")}
	
	it "uses #choose_move method" do
		expect(@player1).to receive(:choose_move)
		@player1.choose_move
	end
end

describe Board do 
  	before do
		@game =  ConnectFour.new
		@game.board.board = [['_','X','_','_','_','_','_'],
				    ['_','X','_','_','_','_','_'],
			  	    ['_','O','_','_','_','_','_'],
				    ['_','X','_','_','_','_','_'],
				    ['_','X','_','_','_','_','_'],
				    ['_','O','_','_','_','_','_']]
		subject.board = @game.board.board
  	end
	

	context "the board" do
		it "will have 42 spaces (6x7)" do
			expect(subject.board.size).to eq(6)
			expect(subject.board.all? {|x| x.size == 7 }).to be true
		end
	end

	context "has methods to check if the columns is OK" do
		it "has a column_in_range? method" do
			expect(@game.board).to respond_to(:column_in_range?)
		end

		it "has a column_has_space? method" do
			expect(@game.board).to respond_to(:column_has_space?)
		end
	end


	context "column_outside_board?" do
		it "will return false if column number is out of board" do
			expect(subject.column_in_range?(8)).to be false
		end

		it "will return true if column number is within the board" do
			expect(subject.column_in_range?(4)).to be true
		end
	end


	context "column_has_space?" do
		it "will return false if selected column has any free spaces" do
			expect(subject.column_has_space?(4)).to be true
		end
 
		it "will return true if selected column has no free spaces" do
			expect(subject.column_has_space?(2)).to be false 
		end
	end

	
	context "#mark_move" do
		it "will update the board with new disc" do
			@game.board.mark_move(3,@game.player1)
			expect(@game.board.board[5]).to eql(['_','O','X','_','_','_','_'])
		end

		it "will put a disk in the higher row if the ones below are taken" do
			subject.mark_move(3,@game.player2)
			subject.mark_move(3,@game.player2)
			expect(subject.board[4]).to eql(['_','X','O','_','_','_','_'])
			expect(subject.board[5]).to eql(['_','O','O','_','_','_','_'])
		end
	end
	
end

describe Board, '#solved' do
    before (:each) do
		@game =  ConnectFour.new
    end
	it "will recognize a horizontal win" do
        @game.board.board = [['O','O','O','X','X','X','O'],['O','_','O','X','O','X','X'],['X','X','X','X','_','_','_'],['X','_','_','_','_','_','_'],['X','_','_','_','_','_','_'],['X','_','_','_','_','_','_']]
        expect(@game.board.horizontal_win?).to be true
	end

	it "will recognize a vertical win" do
        @game.board.board = [['O','_','_','_','_','_','_'],['O','_','_','_','_','_','_'],['X','_','_','_','_','_','_'],['X','_','_','_','_','_','_'],['X','_','_','_','_','_','_'],['X','_','_','_','_','_','_']]
        expect(@game.board.vertical_win?).to be true 
	end
	
	it "will recognize a diagonal win" do
        @game.board.board = [['O','_','_','_','_','_','_'],
                            ['O','O','_','_','_','_','_'],
                            ['X','_','O','X','O','_','_'],
                            ['X','_','O','O','X','_','_'],
                            ['X','_','O','_','_','X','_'],
                            ['X','O','_','_','_','_','X']]
        expect(@game.board.diag_win?(1,3,6,3,5)).to be true #left diagonal win (way = 1)
        expect(@game.board.diag_win?(-1,0,3,3,5)).to be true #right diagonal win (way = -1)

	end
end

