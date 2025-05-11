require 'json'
require 'yaml'
require 'pathname'

BASE_URL = 'https://ricettegiapponesi.jeko.net'
RECIPES_DIR = Pathname.new('recipes')
INGREDIENTS_DIR = Pathname.new('ingredients')

# Estrai testo tra due intestazioni Markdown
def extract_section(content, section)
  regex = /^##\s*#{section}\s*\n(.*?)(?=^##|\z)/m
  match = content.match(regex)
  match ? match[1].strip : nil
end

# Estrai lista puntata come array
def extract_bullets(text)
  return [] unless text
  text.lines.map(&:strip).select { |line| line.start_with?('-') }.map { |line| line[1..].strip }
end

# Estrai immagini e trasformale in URL assoluti
def extract_images(text)
  return [] unless text
  text.scan(/!\[.*?\]\((\/.*?)\)/).map { |match| BASE_URL + match[0] }
end

# Crea URL pubblico a partire dal path relativo
def build_url(file_path)
  BASE_URL + '/' + file_path.to_s
end

# Parsare file Markdown con frontmatter
def parse_markdown(file_path, base_dir:, extract_sections: false)
  content = File.read(file_path)
  if content =~ /\A---\s*\n(.*?)\n---\s*\n(.*)/m
    frontmatter = YAML.safe_load($1)
    body = $2.strip
    relative_path = file_path.relative_path_from(base_dir).to_s
    url = build_url("#{base_dir}/#{relative_path}")

    data = {
      title: frontmatter['title'],
      description: frontmatter['description'],
      url: url,
      content: body,
      images: extract_images(body)
    }

    if extract_sections
      ingredient_text = extract_section(body, 'Ingredienti')
      preparation_text = extract_section(body, 'Preparazione')

      data[:ingredients] = extract_bullets(ingredient_text)
      data[:preparation] = preparation_text
    end

    data
  else
    puts "⚠️ Frontmatter mancante in: #{file_path}"
    nil
  end
end

# Parse ricette
recipes = RECIPES_DIR.glob('**/*.md').map do |file|
  parse_markdown(file, base_dir: RECIPES_DIR, extract_sections: true)
end.compact

# Parse ingredienti
ingredients = INGREDIENTS_DIR.glob('**/*.md').map do |file|
  parse_markdown(file, base_dir: INGREDIENTS_DIR)
end.compact

# Scrittura JSON
output = {
  recipes: recipes,
  ingredients: ingredients
}

File.write('ricettario.json', JSON.pretty_generate(output))
puts "✅ Serializzazione completata: ricettario.json"
puts "📦 #{recipes.size} ricette, #{ingredients.size} ingredienti"
