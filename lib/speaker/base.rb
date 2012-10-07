require 'open-uri'
require 'cgi'
require 'net/http'
require 'mechanize'

module Speaker
  
  class Base

    attr_accessor :language, :text, :audio_file_path

		FILE_NAME = 'audio'
		GOOGLE_TRANSLATOR_PATH = "http://translate.google.com/translate_tts?"
		DEFAULT_LANGUAGE = 'en'
		DEFAULT_TEXT = 'Nothing to say'

		def initialize(options={})
			@language = options[:language] || DEFAULT_LANGUAGE
			@text = options[:text] || DEFAULT_TEXT
			delete_audio_file
		end

		def tts
			to_audio
			play
		end

		def to_audio
			split_sentence
			build_mp3
			join_audio_files
			delete_audio_files
			nil
		end

		def has_audio?
			File.exist?(audio_file)
		end

		def play
			if has_audio?
				`#{player} #{audio_file}`
				@text
			else
				"There is no audio file yet"
			end
		end

		def audio_file
			"#{audio_file_path}/#{FILE_NAME}.mp3"
		end

		private

		def words
			text.split(" ")
		end

		def split_sentence
			words = @text.split(" ")
			block = 0
			data = []
			@content = {block => []}

			words.each_with_index do |word,i|
				if (@content[block] + [word]).join(' ').size >= 100
					block += 1
					@content.merge!({block => [word]})
				else
					@content[block] << word
				end
			end

			@block_loops = block + 1
		end

		def build_mp3
			@block_loops.times do |i|
				sentence = @content[i].join(" ")
	      audio_file = "#{FILE_NAME}-#{i+1}.mp3"
	      url = GOOGLE_TRANSLATOR_PATH + "tl=#{language}&q=#{sentence}"
				type_sentence_and_get_audio(url,audio_file)
		  end
		end

		def type_sentence_and_get_audio(url,audio_file)
			a = Mechanize.new { |agent|
	      agent.user_agent_alias = 'Mac Safari'
	    }

	    a.get(url) do |page|
		    File.open(audio_file, 'wb') do |file|
				  file << page.content
			  end
	    end

		end

		def audio_files
			files = []
			@block_loops.times do |i|
				files << "#{audio_file_path}/#{FILE_NAME}-#{i+1}.mp3"
			end
			files
		end

		def join_audio_files
			inline_files = audio_files.join(" ")
			`ruby -pe '' #{inline_files} > #{audio_file}`
		end

		def delete_audio_files
			audio_files.each do |file|
				File.delete(file)
			end
		end

		def audio_file_path
			Speaker.configuration ? Speaker.configuration.audio_file_path : Configuration.new.audio_file_path
		end

		def delete_audio_file
			File.delete(audio_file) if has_audio?
	  end

	  def player
	  	if RUBY_PLATFORM.include?("darwin")
	  		'afplay'
	  	else
	  		'mpg123'
	  	end
	  end

  end

end