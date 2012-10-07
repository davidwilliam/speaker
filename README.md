# Speaker

Flexible text to speech using Google Translator.

One nice touch of Speaker is that you can transform *texts of any size* to audio. 
Google Translator API limits texts to 100 characters. Speaker deals with that for you.

But, of course, good sense is always appreciated. The longer the text is, the longer will take to transform it to audio.

All said, enjoyt it!

## Installation

Add this line to your application's Gemfile:

    gem 'speaker'

In order to play the mp3 audio, on Mac OS Speaker uses 'afplay'. In my case, it's native.
If you are on Linux, you need to have 'mpg123' installed. If you don't, plase install it first and then install and use the Speaker gem.

I have tested Speaker on Mac OS X Lion and Ubuntu and it worked without problems.
Unfortunately still does not work on Windows but I'll find time in the future to provide that.

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install speaker

## Usage

All you need to start is to create a new Speaker object passing the text you want to transform in audio:

```ruby
speaker = Speaker.new(text: "My name is Bond. James Bond")
```

Now you can just do "text to speech":

```ruby
speaker.tts # It will say "My name is Bond. James Bond"
```

If you want to listen it again:

```ruby
speaker.play # Do not create the audio again. Instead, just play it.
```

If you want, you can create the audio and play it in two steps. (This is exactly what the tts method does):

```ruby
speaker.to_audio # Creates the audio
speaker.play # Play it
```

Whenever a new Speaker object is created, there is no more audio file to play until you want it. So, if you create a new Speaker object and try to play it, there will be no audio file to play and Speaker will let you know that:

```ruby
speaker = Speaker.new
speaker.play # It will return the string: "There is no audio file yet"
```

You can check if there is an audio file by typing:

```ruby
speaker.has_audio? # It returns true or false
```

You can create and play you text in one line by doing:

```ruby
Speaker.new(text: "My name is Bond. James Bond").tts
```

By default, the audio file will be created inside the root path where the gem is running. But, of course, you can change it:

```ruby
Speaker.configure do |config|
  config.audio_file_path = '/new/path' # i.e.: /myapp/media
end
```

To check what is the current audio file path:

```ruby
Speaker.configuration.audio_file_path
```

If you want to create tts in anothers languages:

```ruby
speaker = Speaker.new(language: 'pt', text: 'Olá meu amigo')
speaker.tts # It will say 'Olá meu amigo', which is 'Hello my friend' in portuguese.
```

If you want to return the text and the language:

```ruby
speaker.text # It will return 'Olá meu amigo'
speaker.language # I will return 'pt'
```

English is the default language.

If you create a new Speaker object without passing any information, Speaker will create an object with the text 'Nothing to say'.

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
