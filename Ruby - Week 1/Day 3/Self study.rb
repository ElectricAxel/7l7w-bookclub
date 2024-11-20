# Do: Modify the CSV application to support an `each` method to return a `CsvRow` object.
# Use `method_missing` on that `CsvRow` to return the value of the column for a given heading.`

module ActsAsCsv
    def self.included(base)
        base.extend ClassMethods
    end

    module ClassMethods
        def acts_as_csv
            include InstanceMethods
        end
    end

    module InstanceMethods
        def read
            @csv_contents = []
            filename = self.class.to_s.downcase + '.txt'
            file = File.new( filename ) # TODO: check why this file is not closed and why readonly is not specified
            @headers = file.gets.chomp.split( ', ' );

            file.each do |row|
                @csv_contents << CsvRow.new( self, row.chomp.split( ', ' ) )
            end
        end

        attr_accessor :headers, :csv_contents
        def initialize
            read
        end

        def each(&block)
            @csv_contents.each { |row| block.call row }
        end
    end

    class CsvRow
        attr_accessor :parent, :values

        def initialize(parent, values)
            @parent = parent
            @values = values
        end

        def method_missing(name, *args)
            key = @parent.headers.find_index(name.to_s)
            return @values[key] if key

            super
        end
    end
end

class RubyCsv # no inheritance! You can mix it in
    include ActsAsCsv
    acts_as_csv
end

m = RubyCsv.new
# puts m.headers.inspect
# puts m.csv_contents.inspect


m.each do |row|
    # puts row.inspect
    puts "one: #{row.one}"
    puts "two: #{row.two}"
end