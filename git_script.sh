#!/usr/bin/env bash

# Configuración de estilo mejorada
bold=$(tput bold)
reset=$(tput sgr0)

# Colores Andrómeda mejorados
color_title="\033[1;38;5;111m"    # Azul cielo
color_option="\033[1;38;5;141m"   # Morado suave
color_success="\033[1;38;5;150m"  # Verde menta
color_error="\033[1;38;5;203m"    # Rojo coral
color_input="\033[1;38;5;122m"    # Cian brillante
color_branch="\033[1;38;5;183m"   # Morado claro

# Función para mostrar el encabezado pixelado
show_header() {
  clear
  echo -e "${color_title}"
  echo -e "╔════════════════════════════════════════════╗"
  echo -e "║${bold}                G I T   H U B               ${reset}${color_title}║"
  echo -e "╚════════════════════════════════════════════╝${reset}"
  echo -e "${reset}"
}

show_header

# Verificar repo git
if ! git rev-parse --is-inside-work-tree > /dev/null 2>&1; then
  echo -e "${color_error}✖ Error: No estás en un repositorio Git${reset}"
  exit 1
fi

# Obtener branch actual
current_branch=$(git branch --show-current)

# Paso 1: Git Add
echo -e "${color_option}⋆ ${bold}Paso 1/3:${reset}${color_option} Añadiendo cambios (git add)...${reset}"
git add .
add_status=$?

if [ $add_status -ne 0 ]; then
  echo -e "${color_error}✖ Error en git add${reset}"
  exit 1
fi

# Paso 2: Git Commit
echo -e "\n${color_option}⋆ ${bold}Paso 2/3:${reset}${color_option} Creando commit...${reset}"
echo -e "${color_input}🌱 Mensaje del commit:${reset} "
read -p "   " commit_message

if [ -z "$commit_message" ]; then
  commit_message="Actualización del checklist"
fi

git commit -m "$commit_message"
commit_status=$?

# Paso 3: Git Push
if [ $commit_status -eq 0 ]; then
  echo -e "\n${color_option}⋆ ${bold}Paso 3/3:${reset}${color_option} Subiendo cambios a ${color_branch}${current_branch}${color_option}...${reset}"
  git push origin $current_branch
  push_status=$?
else
  echo -e "${color_error}✖ Error en git commit${reset}"
  exit 1
fi

# Resultado final
show_header
if [ $push_status -eq 0 ]; then
  echo -e "${color_success}✔ ¡Cambios subidos a GitHub!${reset}"
  echo -e "\n${color_option}↳ Branch:  ${color_branch}${current_branch}"
  echo -e "${color_option}↳ Mensaje: ${reset}\"$commit_message\""
  echo -e "\n${color_success}♪ Todos los cambios están en la nube ♪${reset}"
else
  echo -e "${color_error}✖ Error en git push${reset}"
  echo -e "\n${color_option}Intenta manualmente: ${reset}git push origin ${current_branch}"
fi

echo -e "\n${color_title}Presiona cualquier tecla para salir...${reset}"
read -n 1 -s