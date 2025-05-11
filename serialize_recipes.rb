require 'json'
require 'yaml'
require 'pathname'

ROOT_DIR = Pathname.new('recipes')

def extract_section(content, section)
  regex = /^##\s*#{section}\s*\n(.*?)(?=^##|\z)/m
  match = content.match(regex)
  match ? match[1].strip : nil
end

def extract_bullets(text)
  return [] unless text
  text.lines.map(&:strip).select { |line| line.start_with?('-') }.map { |line| line[1..].strip }
end

def parse_recipe(file_path)
  content = File.read(file_path)
  if content =~ /\A---\s*\n(.*?)\n---\s*\n(.*)/m
    frontmatter = YAML.safe_load($1)
    body = $2.strip

    ingredient_text = extract_section(body, 'Ingredienti')
    preparation_text = extract_section(body, 'Preparazione')

    {
      title: frontmatter['title'],
      description: frontmatter['description'],
      path: file_path.relative_path_from(ROOT_DIR).to_s,
      content: body,
      ingredients: extract_bullets(ingredient_text),
      preparation: preparation_text
    }
  else
    puts "⚠️ Frontmatter mancante in: #{file_path}"
    nil
  end
end

recipes = ROOT_DIR.glob('**/*.md').map do |file|
  parse_recipe(file)
end.compact

output_path = 'ricettario.json'
File.write(output_path, JSON.pretty_generate(recipes))

puts "✅ Serializzazione completata: #{output_path} (#{recipes.size} ricette)"
