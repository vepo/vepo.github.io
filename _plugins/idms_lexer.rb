# -*- coding: utf-8 -*- #
# frozen_string_literal: true

module Rouge
  module Lexers
    class IDMS < RegexLexer
      title 'IDMS DML'
      desc 'IDMS Data Manipulation Language'
      tag 'idms'
      filenames '*.idms'

      state :root do
        rule %r/\s+/, Text::Whitespace
        rule %r/\/\*.*?\*\//m, Comment::Multiline
        rule %r/"[^"]*"/, Str::Double
        rule %r/\b(PROCEDURE|BEGIN|END|DECLARE|FIND|FIRST|NEXT|OWNER|WITHIN|OF|ON|ERROR|DISPLAY|AND|EXIT|REPEAT|USING|SET|IF|THEN|ELSE)\b/i, Keyword
        rule %r/\b[A-Z_][A-Z0-9_]*\b/, Name
        rule %r/[;=.]/, Punctuation
      end
    end
  end
end