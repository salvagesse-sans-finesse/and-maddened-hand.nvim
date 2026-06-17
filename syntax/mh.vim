syntax match mhCheckboxUnticked /\[ \]/
syntax match mhCheckboxTicked /- \[x\] .*$/
syntax match mhLink /:[a-zA-Z0-9]\+/

highlight link mhCheckboxUnticked Keyword
highlight link mhCheckboxTicked Comment
highlight link mhLink Keyword
