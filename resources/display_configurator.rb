class DisplayConfigurator
    def initialize(width, height, text_to_display)
        @width = width
        @height = height
        @text_to_display = text_to_display
    end

    def set_size
        # set constraints
        longest_word_max_char_size = @width / min_char_per_line
        max_char_size = longest_word_max_char_size < overall_max_char_size ? longest_word_max_char_size : overall_max_char_size
        previous_max_char_size = -1
        return max_char_size if max_char_size == 0

        # check if words split with this constraints
        while true
            max_char_in_line = @width / max_char_size
            max_lines = @height / max_char_size

            strings_per_line = []
            max_lines.times do
                strings_per_line << ""
            end

            i = 0
            @words_to_display.each_with_index do |word, index|
                line_empty = strings_per_line[i].length == 0
                has_space_for_word = line_empty ? true : strings_per_line[i].length + word.length + 1 <= max_char_in_line

                if has_space_for_word && !line_empty
                    strings_per_line[i] += " "
                elsif !has_space_for_word
                    i += 1
                    if i == max_lines
                        max_char_size -= 1
                        break
                    end
                end

                strings_per_line[i] += word

                if index == @words_to_display.length - 1
                    # print strings_per_line
                    return max_char_size
                end
            end
        end
    end

    def overall_max_char_size
        number_of_characters = @text_to_display.length
        available_area = @height * @width
        area_per_character = available_area / number_of_characters
        max_size = (area_per_character ** (1.0/2)).floor
    end

    def min_char_per_line
        @words_to_display = @text_to_display.split(" ")
        longest_word = @words_to_display.max_by(&:length)
        longest_word.length
    end

end


dc1 = DisplayConfigurator.new(27, 15, "May the Force be with you")
dc2 = DisplayConfigurator.new(10, 40, "Legen wait-for-it dary, legendary")
dc3 = DisplayConfigurator.new(420, 100, "You want the truth? You can't handle the truth")
dc4 = DisplayConfigurator.new(65, 65, "Houston, we have a problem")
dc5 = DisplayConfigurator.new(345, 160, "My mama always said life was like a box of chocolates. You never know what you're gonna get")
dc6 = DisplayConfigurator.new(230, 130, "You know nothing, Jon Snow")
dc7 = DisplayConfigurator.new(14, 10, "Dobby is free")
dc8 = DisplayConfigurator.new(15, 80, "Say 'hello' to my little friend!")
dc9 = DisplayConfigurator.new(100, 15, "Live long and prosper")
dc10 = DisplayConfigurator.new(23, 2, "Bazinga")


puts(dc1.set_size)
puts(dc2.set_size)
puts(dc3.set_size)
puts(dc4.set_size)
puts(dc5.set_size)
puts(dc6.set_size)
puts(dc7.set_size)
puts(dc8.set_size)
puts(dc9.set_size)
puts(dc10.set_size)
