# coding: utf-8
# Project Norminette in ruby
# Cerfio

ARGV

def check_header(i, line, after)
  if (i == 0 && line[0] != "/")
    puts("Pas de Header")
    return (1)
  end
  if (i == 0)
    return (0)
  end
  if (line[0] != "*")
    puts("Header invalide " + i.to_s)
    return (1)
  end
  if (line[0] == "*" && line[1] == "/")
    if (after[0] != "\n")
      puts("Saut de ligne manquand apres le Header")      
    end
    return (1)
  end
  return (0)
end

def check_space_end_line(line, i)
  len = line.length
  if (line[len - 2] == " ")
    puts("Espace en trop en fin de ligne " + i.to_s)
  elsif (line[len - 2] == "\t")
    puts("Tabulation en trop en fin de ligne " + i.to_s)
  end
end

def check_new_line_function(line, line_before, i)
  numberline = i + 1
  if (i > 0 && line_before[0] == "}" && line[0] != "\n")
    puts("Saut de ligne manquant ligne " + numberline.to_s)
  end
end

def check_control_structure()

end

def check_uppercase(line, i)
  count = 0
  while (line[count] != "\n")
    if (line[count] >= "A" && line[count] <= "Z")
      puts("Variable ou fonction en majuscule ligne " + i.to_s)
      return (0)
    end
    count = count + 1
  end
end

def check_long_line(line, i)
  len = 0
  count = 0
  while (line[count] != "\n")
    if (line[count] == "\t")
      len = len + 7
    end
    len = len + 1
    count = count + 1
  end
  if (len > 80)
    puts("Ligne trop longue " + len.to_s + " ligne " + i.to_s)
  end
end

def read_file
  fichier = File.open(ARGV[0],'r').readlines
  i = 0
  while (check_header(i, fichier[i], fichier[i + 1]) != 1)
    i = i + 1
  end
  while (fichier[i])
    check_uppercase(fichier[i], i + 1)
    check_space_end_line(fichier[i], i + 1)
    check_new_line_function(fichier[i], fichier[i - 1], i)
    check_long_line(fichier[i], i + 1)
    i = i + 1
  end
end

read_file()
