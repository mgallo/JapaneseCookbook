require 'json'
require 'yaml'
require 'pathname'

ROOT_DIR = Pathname.new('recipes')

def parse_recipe(file_path)
  content = File.read(file_path)
  if content =~ /\A---\s*\n(.*?)\n---\s*\n(.*)/m
    frontmatter = YAML.safe_load($1)
    body = $2.strip

    {
      title: frontmatter['title'],
      description: frontmatter['description'],
      path: file_path.relative_path_from(ROOT_DIR).to_s,
      content: body
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
