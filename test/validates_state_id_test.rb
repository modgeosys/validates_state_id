require 'test/unit'

begin
  require File.dirname(__FILE__) + '/../../../../config/boot'
  require 'active_record'
  require 'validates_state_id'
rescue LoadError
  require 'rubygems'
  require 'activerecord'
  require File.dirname(__FILE__) + '/../lib/validates_state_id'
end

class Person < ActiveRecord::Base
  def self.columns; []; end
  attr_accessor :number, :us_state
  validates_as_state_id :number, :state_field => :us_state
  #:allow_nil => false # false is default
end

class ValidatesStateIdTest < Test::Unit::TestCase
   
  def self.no_rules_defined_good
    [ 'abc', '123', '1v3c5n7m9q1t3y5' ]
  end
  
  def self.no_rules_defined_bad
    [ 'ab', '13', '1v3c5n7m9q1t3y5P' ]
  end
  
  def self.one_alpha_12_numeric
    [ 'a123456789012', 'z000000000000' ]
  end
  
  def self.nine_numeric
    [ '987654321', '000000000' ]
  end

  def self.license_id_rules
    # structure describing state, required format for state id, valid state ids, invalid state ids:
    [
      [ 'AL','7 Numeric or 1 Alpha + 6 Numeric',
        [ '1234567', 'z234567' ],
        ['', '123456', '12345678', '*234567', 'b1234567' ] ],
        
      [ 'AZ', 'SSN or 1 Alpha (A, B, D, Y) + 8 Numeric',
        [ '123456789', 'A23456789', 'b23456789',  'd23456789', 'Y23456789', 'a00000000' ],
        [ '12345678', '12345678a', 'C234567890', 'B2345678',  'd234567890', 'y234567*9' ] ],
        
      [ 'AR', '8 Numeric with zero in front or 9 Numeric',
        [ '02345678', '023456789', '00000000' ],
        [ '0234567', '0234567890', '12345678', '12345678n', '1234567*9' ] ],
        
      [ 'CA', '1 Alpha + 7 Numeric',
        [ 'a1234567', 'z0000000' ],
        [ '12345678', 'Q123456', 'A12345678', 'A123456s', 'Z12345*7' ] ],
        
      [ 'CO', '3 to 15 Alpha/Numeric', no_rules_defined_good, no_rules_defined_bad ],
      
      [ 'CT', '9 Numeric',
        nine_numeric,
        [ '98765432', '9876543210', '9876543t1', '9*7654321' ] ],
        
      [ 'DE', '1 to 7 Numeric',
        [ '1', '12', '1234567', '0000000' ],
        [ 'a', '#3', '12345^', '12345678', '123f5678' ] ],
        
      [ 'DC', '3 to 15 Alpha/Numeric', no_rules_defined_good, no_rules_defined_bad ],

      [ 'FL', '1 Alpha + 12 Numeric',
        one_alpha_12_numeric,
        [ 'X12345678901', 'X1234567890123', '0000000000000', 'x123456&89012', 'x123456789O12' ] ],
        
      [ 'GA', '7 to 9 Numeric',
        [ '1234567', '87654321', '000000000' ],
        [ '123456', '1234567890', '123456s', '12345s78', '1234f6789', '123$56789' ] ],
        
      [ 'HI', '9 Numeric',
        nine_numeric,
        [ '98765432', '9876543210', '9876543t1', '9*7654321' ] ],
        
      [ 'ID', 'New - 9 Characters, Old - 9 Numeric',
        [ '987654321', '000000000', 'ottffssen', 'OTTFFSSEN' ],
        [ '98765432', '9876543210', 'n87654321', 'abcdefgh1', 'abcdefgh', 'abcdefghij', '!23456789', '1234%6789', 'ab defghi' ] ],
        
      [ 'IL', '1 Alpha + 11 Numeric',
        [ 't12345678901', 'Z00000000000' ],
        [ 'm1234567890', 'M123456789012', '000000000000', 'x123456&8901', 'x1234567890)' ] ],
        
      [ 'IN', '10 Numeric or 1 Alpha + 9 Numeric',
        [ '0987654321', 'V987654321' ],
        [ '123456789', '12345678901', '*234567890', 'v1234567890', 'B1234567890' ] ],
        
      [ 'IA', '9 Numeric or 3 numbers, 2 letters, and 4 numbers',
        [ '987654321', '000000000', '123aB9876', '000OO0000' ],
        [ '12ab1234', '1234xy1234', '123A1234', '123XYZ1234', '123cd123', '123CD12345', 'a23ef1234', '12Fgh1234', '1239G1234', '123E81234', '123hio234', '123HI123*', '1@3jk1234' ] ],
        
      [ 'KS', '9 Numeric or the alpha K + 8 Numeric',
        [ '123456789', 'K00000000' ],
        [ '12345678', '12345678a', 'L234567890', 'J2345678',  'k2345678N0', 'K234567*9' ] ],
        
      [ 'KY', '1 Alpha + 8 Numeric',
        [ 'w12345678', 'f00000000' ],
        [ '123456789', 'Q1234567', 'A123456789', 'A1234567s', 'Z12345*78' ] ],
        
      [ 'LA', '9 Numeric (2 zeroes + 7 Numeric)',
        [ '001234567', '000000000' ] ,
        [ '00123456', '0012345678', '801234567', '081234567', '00I234567', '00123456e' ] ],
        
      [ 'ME', '7 Numeric',
        [ '9182734', '0000000' ],
        [ '123456', '12345678', 'd234567', '123456S' ] ],
        
      [ 'MD', '1 Alpha + 12 Numeric',
        one_alpha_12_numeric,
        [ 'X12345678901', 'X1234567890123', '0000000000000', 'x123456&89012', 'x123456789O12' ] ],
        
      [ 'MA', '9 Numeric or the alpha S + 8 Numeric',
        [ '123456789', 's00000000' ],
        [ '12345678', '12345678a', '1234567890', 'S2345678', 'D12345678', 'S234568N0', 's234567*9' ] ],
        
      [ 'MI', '1 Alpha + 12 Numeric',
        one_alpha_12_numeric,
        [ 'X12345678901', 'X1234567890123', '0000000000000', 'x123456&89012', 'x123456789O12' ] ],
        
      [ 'MN', '1 Alpha + 12 Numeric',
        one_alpha_12_numeric,
        [ 'X12345678901', 'X1234567890123', '0000000000000', 'x123456&89012', 'x123456789O12' ] ],
         
      [ 'MS', '9 Numeric',
        nine_numeric,
        [ '98765432', '9876543210', '9876543t1', '9*7654321' ] ],
        
      [ 'MO', '9 Numeric or 1 Alpha + 5-9 Numeric',
        nine_numeric + [ 'a12345', 'Z123456789' ],
        [ '12345678', '12345678a', '1234567890' ] + [ '123456', '!12345', 'a1234', 'Z1234567890' ] ],
        
      [ 'MT', '13 Numeric or 9 alpha-numeric',
        [ '3210987654321', '0000000000000' ] + [ 'a1b2c3d4E', '9Z8y7X6w5' ],
        [ '123456789012', '123456789012a', '12345678901234' ] + [ '1b2c3d4E', '9Z8y7X6w5V', '9Z8y7X6w%' ] ],
        
      [ 'NE', '1 Alpha (A, B, C, E, G, H, V) + 3-8 Numeric',
          [ 'A123', 'B12345678', 'c123', 'E1234', 'G12345', 'h123456', 'V12345678' ],
          [ 'D123', 'F1234', 'i12345', 'W123456', 'U1234567', 'A12', 'V123456789' ] ],
          
      [ 'NV', '10 Numeric or 12 Numeric or "X" + 8 Numeric',
          [ '0987654321', '0000000000' ] + [ '210987654321', '000000000000' ] + [ 'X19283746', 'X00000000', 'x99999999' ],
          [ '123456789', '12345678901', '1234567890123', '123456s890', '123$56789012', 'X1928374', 'x123456789' ] ],
          
      [ 'NH', '2 Numeric + 3 Alpha + 5 Numeric',
          [ '12abc12345', '00AZZ00000' ],
          [ '1abc123455', '123abc1234', '12ab123456', '12abcd1234', '12abc1234', '12abc123456', '!2abc12345', '12ab*12345', '12abc)0000' ] ],
          
      [ 'NJ', '1 Alpha + 14 Numeric',
        [ 'j12345678901234', 'J10293847567483' ],
        [ 'm1234567890123', 'M123456789012345', '000000000000000', 'x123456&8901234', 'x1234567890)234' ] ],
        
      [ 'NM', '9 Numeric',
        nine_numeric,
        [ '98765432', '9876543210', '9876543t1', '9*7654321' ] ],
        
      [ 'NY', '9 Numeric or 1 Alpha + 18 Numeric',
          nine_numeric + [ 'a876543210987654321', 'Z000000000000000000'],
          [ '12345678', '12345678a', '1234567890' ] + [ '0123456789012345678', 'a76543210987654321', 'y9876543210987654321', 'ab76543210987654321', 'a87654321098765432a', 'a8&6543210987654321' ] ],
          
      [ 'NC', '1-12 Numeric',
          [ '8', '000000000000', '10987654321' ],
          [ 'a', '3210987654321', '109*7654321' ] ],
          
      [ 'ND', '9 Numeric or 3 Alpha + 6 Numeric',
          nine_numeric + [ 'DeF333555', 'zaq000000' ],
          [ '12345678', '12345678a', '1234567890' ] + [ '1eF333555', 'De3333555', 'DeFG33555', 'DeF3335555' ] ],
          
      [ 'OH', '2 Alpha + 6 Numeric',
          [ 'zA990011', 'Zb000000' ],
          [ 'a990011', 'a9990011', 'Aab90011', 'Aab990011', 'zA9900115', 'zA99001'] ],
          
      [ 'OK', '1 Alpha + 9 Numeric or 9 Numeric',
          [ 'a000000000', 'Z999999999' ] + nine_numeric,
          [ 'a12345678', 'a1234567890', 'aZ23456789', 'aZ123456789', 'a1@3456789', 'a1234567890' ] + [ '12345678', '12345678a', '1234567890' ] ],
          
      [ 'OR', '1 to 9 Numeric',
          [ '0', '55555', '999999999' ],
          [ 'A', '88888888a', '1234567890' ] ],
          
      [ 'PA', '3 to 15 Alpha/Numeric', no_rules_defined_good, no_rules_defined_bad ],
      
      [ 'RI', '7 Numeric or "V" + 6 Numeric',
        [ '1234567', 'v000000' ],
        [ '123456', '123456a', '12345678', 'V12345', 'v1234567', 'u123456' ] ],
        
      [ 'SC', '1 to 10 Numeric',
        [ '0', '55555', '1010101010' ],
        [ 'Z', '999999999a', '12345678901' ] ],
        
      [ 'SD', '6 or 8 Numeric or SSN',
          [ '654321', '000000' ] + [ '87654321', '00000000' ] + nine_numeric,
          [ '54321', '7654321', '1234n0', 'n0000000' ] + [ '12345678a', '1234567890' ] ],
          
      [ 'TN', '7 to 9 Numeric',
          [ '7777777', '88888888', '000000000' ],
          [ '666666', '0000000010', '123456s89' ] ],
          
      [ 'TX', '8 Numeric',
        [ '91827345', '00000000', '99999999' ],
        [ '1234567', '123456789', 'y234567', '1234567u' ] ],
        
      [ 'UT', '4 to 9 Numeric',
          [ '4444', '000000000', '7777777' ],
          [ '333', '0123456789', '1t3456789' ] ],
          
      [ 'VT', '8 Numeric or 7 Numeric + 1 Alpha',
          [ '87654321', '00000000' ] + [ '1234567z' ],
          [ '1234567', '123456789', '123456sz', 'o234567u', '1234567sz' ] ],
          
      [ 'VA', '9 Numeric or 1 Alpha + 8 Numeric',
          nine_numeric + [ 'w12345678', 'f00000000' ],
          [ '12345678', '12345678a', '1234567890' ] + [ 'Q1234567', 'A123456789', 'A1234567s', 'Z12345*78' ] ],
          
      [ 'WA', '12 Alpha/Numeric',
          [ 'a1b2c3d4E5f6', '9Z8y7X6w5V4v' ],
          [ 'a1b2c3d4E5f',  '9Z8y7X6w5V4v3', 'a1b2c3d4E5f%' ] ],
          
      [ 'WV', '7 Alpha/Numeric',
        [ 'a1b2c3d', '9Z8y7X6' ],
        [ 'a1b2c3',  '9Z8y7X6w', 'a1b2c%4' ] ],
        
      [ 'WI', '1 Alpha + 13 Numeric',
        [ 'A1234567890123', 'z0000000000000' ],
        [ 'X123456789012', 'X12345678901234', '00000000000000', 'x123456789o123' ] ],
        
      [ 'WY', '9 Numeric',
        nine_numeric,
        [ '98765432', '9876543210', '9876543t1', '9*7654321' ] ]
    ]
  end    
  
  license_id_rules.each do |state, error_message, valid_ids, invalid_ids|
 
    valid_ids.each do |valid|
   
      define_method "test_#{state}_valid_#{valid}" do
        assert_valid_number(valid, state)
      end
      
    end
    
    invalid_ids.each do |invalid_id|
   
      define_method "test_#{state}_invalid_#{invalid_id}" do
        assert_valid_number(invalid_id, state, false)
        assert_equal "#{state} must have the following format: #{error_message}", @person.errors[:number]
      end
 
    end
    
    def test_no_state
      assert_valid_number('A1234567890123', '')
    end
    
    def test_lower_case_state
      assert_valid_number('A1234567890123', 'wi')
    end
    
    def test_invalid_state
      assert_valid_number('A1234567890123', 'JA', false)
      assert_equal "JA is not valid", @person.errors[:us_state]
    end
    
    def test_invalid_lowercase_state
      assert_valid_number('A1234567890123', 'ja', false)
      assert_equal "ja is not valid", @person.errors[:us_state]
    end
    
    def assert_valid_number(number, state, expected=true)
      @person = Person.new(:number => number, :us_state => state)
      assert_equal expected, @person.valid?
    end
 
  end
  
end
