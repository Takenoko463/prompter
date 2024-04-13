class Ai < ActiveHash::Base
  self.data = [
    { id: 1, name: 'ChatGPT', url: 'https://chat.openai.com/' }, { id: 2, name: 'Gemini', url: 'https://gemini.google.com/' }
  ]
end
