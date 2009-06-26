module ValidatesStateId
  
  module States
    
    def self.no_format_rules
      { :synopsis => '3 to 15 Alpha/Numeric', :rules => [ /\w{3,15}/ ] }
    end
    
    def self.nine_numeric
      { :synopsis => '9 Numeric', :rules => [ /\d{9}/ ] }
    end
    
    def self.one_alpha_12_numeric
      { :synopsis => '1 Alpha + 12 Numeric', :rules => [ /[A-Za-z]\d{12}/ ] }
    end
    
    def self.descriptors(state)
      return states[state]
    end
   
    def self.states
      {
        'NONE'=> { :synopsis => '', :rules => nil },
        'AL' => { :synopsis => '7 Numeric or 1 Alpha + 6 Numeric', :rules => [ /\w\d{6}/ ] },
        'AK' => no_format_rules,
        'AZ' => { :synopsis => 'SSN or 1 Alpha (A, B, D, Y) + 8 Numeric', :rules => [ /(A|B|D|Y|a|b|d|y|\d)\d{8}/ ] },
        'AR' => { :synopsis => '8 Numeric with zero in front or 9 Numeric', :rules => [ /0\d{7}/, /\d{9}/ ] },
        'CA' => { :synopsis => '1 Alpha + 7 Numeric', :rules => [ /[A-Za-z]\d{7}/ ] },
        'CO' => no_format_rules,
        'CT' => nine_numeric,
        'DE' => { :synopsis => '1 to 7 Numeric', :rules => [ /\d{1,7}/ ] },
        'DC' => no_format_rules,
        'FL' => one_alpha_12_numeric,
        'GA' => { :synopsis => '7 to 9 Numeric', :rules => [ /\d{7,9}/ ] },
        'HI' => nine_numeric,
        'ID' => { :synopsis => 'New - 9 Characters, Old - 9 Numeric', :rules => [ /([A-Za-z]{9}|\d{9})/ ] },
        'IL' => { :synopsis => '1 Alpha + 11 Numeric', :rules => [ /[A-Za-z]\d{11}/ ] },
        'IN' => { :synopsis => '10 Numeric or 1 Alpha + 9 Numeric', :rules => [ /\w\d{9}/ ] },
        'IA' => { :synopsis => '9 Numeric or 3 numbers, 2 letters, and 4 numbers', :rules => [ /\d{9}/, /\d{3}[A-Za-z]{2}\d{4}/ ] },
        'KS' => { :synopsis => '9 Numeric or the alpha K + 8 Numeric', :rules => [ /(K|k|\d)\d{8}/ ] },
        'KY' => { :synopsis => '1 Alpha + 8 Numeric', :rules => [ /[A-Za-z]\d{8}/ ] },
        'LA' => { :synopsis => '9 Numeric (2 zeroes + 7 Numeric)', :rules => [ /00\d{7}/ ] },
        'ME' => { :synopsis => '7 Numeric', :rules => [ /\d{7}/ ] },
        'MA' => { :synopsis => '9 Numeric or the alpha S + 8 Numeric', :rules => [ /(S|s|\d)\d{8}/ ] },      
        'MD' => one_alpha_12_numeric,
        'MI' => one_alpha_12_numeric,
        'MN' => one_alpha_12_numeric,
        'MS' => nine_numeric,
        'MO' => { :synopsis => '9 Numeric or 1 Alpha + 5-9 Numeric', :rules => [ /\d{9}/, /[A-Za-z]\d{5,9}/ ] },
        'MT' => { :synopsis => '13 Numeric or 9 alpha-numeric', :rules => [ /\d{13}/, /\w{9}/ ] },
        'NE' => { :synopsis => '1 Alpha (A, B, C, E, G, H, V) + 3-8 Numeric', :rules => [ /(A|B|C|E|G|H|V|a|b|c|e|g|h|v)\d{3,8}/ ] },
        'NV' => { :synopsis => '10 Numeric or 12 Numeric or "X" + 8 Numeric', :rules => [ /\d{10}/, /\d{12}/, /(X|x)\d{8}/ ] },
        'NH' => { :synopsis => '2 Numeric + 3 Alpha + 5 Numeric', :rules => [ /\d{2}[A-Za-z]{3}\d{5}/ ] },
        'NJ' => { :synopsis => '1 Alpha + 14 Numeric', :rules => [ /[A-Za-z]\d{14}/ ] },
        'NM' => nine_numeric,
        'NY' => { :synopsis => '9 Numeric or 1 Alpha + 18 Numeric', :rules => [ /\d{9}/, /[A-Za-z]\d{18}/ ] },
        'NC' => { :synopsis => '1-12 Numeric', :rules => [ /\d{1,12}/ ] },
        'ND' => { :synopsis => '9 Numeric or 3 Alpha + 6 Numeric', :rules => [ /\d{9}/, /[A-Za-z]{3}\d{6}/ ] },
        'OH' => { :synopsis => '2 Alpha + 6 Numeric', :rules => [ /[A-Za-z]{2}\d{6}/ ] },
        'OK' => { :synopsis => '1 Alpha + 9 Numeric or 9 Numeric', :rules => [ /[A-Za-z]\d{9}/, /\d{9}/ ] },
        'OR' => { :synopsis => '1 to 9 Numeric', :rules => [ /\d{1,9}/ ] },
        'PA' => no_format_rules,
        'RI' => { :synopsis => '7 Numeric or "V" + 6 Numeric', :rules => [ /(V|v|\d)\d{6}/ ] },
        'SC' => { :synopsis => '1 to 10 Numeric', :rules => [ /\d{1,10}/ ] },
        'SD' => { :synopsis => '6 or 8 Numeric or SSN', :rules => [ /\d{6}/, /\d{8,9}/ ] },
        'TN' => { :synopsis => '7 to 9 Numeric', :rules => [ /\d{7,9}/ ] },
        'TX' => { :synopsis => '8 Numeric', :rules => [ /\d{8}/ ] },
        'UT' => { :synopsis => '4 to 9 Numeric', :rules => [ /\d{4,9}/ ] },
        'VT' => { :synopsis => '8 Numeric or 7 Numeric + 1 Alpha', :rules => [ /\d{7}\w/ ] },
        'VA' => { :synopsis => '9 Numeric or 1 Alpha + 8 Numeric', :rules => [ /\w\d{8}/ ] },
        'WA' => { :synopsis => '12 Alpha/Numeric', :rules => [ /\w{12}/ ] },
        'WV' => { :synopsis => '7 Alpha/Numeric', :rules => [ /\w{7}/ ] },
        'WI' => { :synopsis => '1 Alpha + 13 Numeric', :rules => [ /[A-Za-z]\d{13}/ ] },
        'WY' => nine_numeric,
      }
    end 
  end
  
end