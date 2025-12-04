#!/bin/bash
set -e

mkdir -p output

# Copy all theme CSS files
cp theme-*.css output/

# Create a temporary markdown file for the HTML site that includes the download link
cp resume.md resume-site.md
echo -e "\n\n[Download PDF](resume.pdf)" >> resume-site.md

# Generate HTML with the default theme (clean) and inject the switcher
# We use -c theme-clean.css to link it, and --include-before-body to add the switcher
pandoc resume-site.md -f markdown -t html -c theme-clean.css -s --include-before-body=theme-switcher.html -o output/index.html

# Add ID to the link tag so JS can find it
sed 's/href="theme-clean.css"/href="theme-clean.css" id="theme-style"/' output/index.html > output/index.html.tmp && mv output/index.html.tmp output/index.html

# Cleanup temp markdown
rm resume-site.md

# Generate PDFs for all themes
THEMES=('clean' 'modern' 'classic' 'terminal' 'bold')

for theme in "${THEMES[@]}"; do
    echo "Building PDF for theme: $theme"
    
    # Create a temp html for this theme
    pandoc resume.md -f markdown -t html -c "theme-$theme.css" -s -o "output/resume-$theme.html"
    
    if [ "$theme" == "modern" ]; then
        # Modern theme has color variants
        COLORS=('blue' 'red' 'orange' 'green' 'purple' 'black' 'grey')
        
        for color in "${COLORS[@]}"; do
            echo "  Building variant: $theme-$color"
            
            # Create a variant HTML with the color class injected
            cp "output/resume-$theme.html" "output/resume-$theme-$color.html"
            
            # Inject class into body
            sed "s/<body/<body class=\"color-$color\" /" "output/resume-$theme-$color.html" > "output/resume-$theme-$color.html.tmp" && mv "output/resume-$theme-$color.html.tmp" "output/resume-$theme-$color.html"
            
            # Determine PDF filename
            if [ "$color" == "blue" ]; then
                OUT_PDF="output/resume-$theme.pdf"
            else
                OUT_PDF="output/resume-$theme-$color.pdf"
            fi
            
            wkhtmltopdf --page-size Letter --margin-top 0mm --margin-bottom 0mm --margin-left 0mm --margin-right 0mm --enable-local-file-access "output/resume-$theme-$color.html" "$OUT_PDF"
            
            rm "output/resume-$theme-$color.html"
        done
        
        # Clean up the base html
        rm "output/resume-$theme.html"
        
    elif [ "$theme" == "classic" ]; then
        # Classic theme has Font and Texture variants
        # Fonts: merriweather (default), georgia, times, arial
        # Textures: clean (default), paper, sepia, dark
        
        FONTS=('merriweather' 'georgia' 'times' 'arial')
        TEXTURES=('clean' 'paper' 'sepia' 'dark')
        
        for font in "${FONTS[@]}"; do
            for texture in "${TEXTURES[@]}"; do
                echo "  Building variant: classic-$font-$texture"
                
                # Create variant HTML
                cp "output/resume-$theme.html" "output/resume-$theme-$font-$texture.html"
                
                # Construct class string
                CLASSES=""
                
                # Font class
                if [ "$font" != "merriweather" ]; then
                    CLASSES="$CLASSES font-$font"
                fi
                
                # Texture class
                if [ "$texture" != "clean" ]; then
                    CLASSES="$CLASSES texture-$texture"
                fi
                
                # Inject classes if any
                if [ -n "$CLASSES" ]; then
                    sed "s/<body/<body class=\"$CLASSES\" /" "output/resume-$theme-$font-$texture.html" > "output/resume-$theme-$font-$texture.html.tmp" && mv "output/resume-$theme-$font-$texture.html.tmp" "output/resume-$theme-$font-$texture.html"
                fi
                
                # Determine PDF filename
                # Logic: resume-classic[-font][-texture].pdf
                # Defaults (merriweather, clean) are omitted
                
                SUFFIX=""
                if [ "$font" != "merriweather" ]; then
                    SUFFIX="-$font"
                fi
                if [ "$texture" != "clean" ]; then
                    SUFFIX="$SUFFIX-$texture"
                fi
                
                OUT_PDF="output/resume-$theme$SUFFIX.pdf"
                
                wkhtmltopdf --page-size Letter --margin-top 0mm --margin-bottom 0mm --margin-left 0mm --margin-right 0mm --enable-local-file-access "output/resume-$theme-$font-$texture.html" "$OUT_PDF"
                
                rm "output/resume-$theme-$font-$texture.html"
            done
        done
        
        rm "output/resume-$theme.html"

    elif [ "$theme" == "bold" ]; then
        # Bold theme has color variants (Red is default)
        COLORS=('blue' 'red' 'orange' 'green' 'purple' 'black' 'grey')
        
        for color in "${COLORS[@]}"; do
            echo "  Building variant: $theme-$color"
            
            # Create a variant HTML with the color class injected
            cp "output/resume-$theme.html" "output/resume-$theme-$color.html"
            
            # Inject class into body
            sed "s/<body/<body class=\"color-$color\" /" "output/resume-$theme-$color.html" > "output/resume-$theme-$color.html.tmp" && mv "output/resume-$theme-$color.html.tmp" "output/resume-$theme-$color.html"
            
            # Determine PDF filename
            if [ "$color" == "red" ]; then
                OUT_PDF="output/resume-$theme.pdf"
            else
                OUT_PDF="output/resume-$theme-$color.pdf"
            fi
            
            wkhtmltopdf --page-size Letter --margin-top 0mm --margin-bottom 0mm --margin-left 0mm --margin-right 0mm --enable-local-file-access "output/resume-$theme-$color.html" "$OUT_PDF"
            
            rm "output/resume-$theme-$color.html"
        done
        
        # Clean up the base html
        rm "output/resume-$theme.html"

    elif [ "$theme" == "clean" ]; then
        # Clean theme has a Dark Mode variant
        
        # 1. Default (Light)
        wkhtmltopdf --page-size Letter --margin-top 0mm --margin-bottom 0mm --margin-left 0mm --margin-right 0mm --enable-local-file-access "output/resume-$theme.html" "output/resume.pdf"
        
        # 2. Dark Mode
        echo "  Building variant: clean-dark"
        cp "output/resume-$theme.html" "output/resume-dark.html"
        sed "s/<body/<body class=\"dark-mode\" /" "output/resume-dark.html" > "output/resume-dark.html.tmp" && mv "output/resume-dark.html.tmp" "output/resume-dark.html"
        wkhtmltopdf --page-size Letter --margin-top 0mm --margin-bottom 0mm --margin-left 0mm --margin-right 0mm --enable-local-file-access "output/resume-dark.html" "output/resume-dark.pdf"
        rm "output/resume-dark.html"
        
        rm "output/resume-$theme.html"

    else
        # Standard themes
        OUT_PDF="output/resume-$theme.pdf"
        
        wkhtmltopdf --page-size Letter --margin-top 0mm --margin-bottom 0mm --margin-left 0mm --margin-right 0mm --enable-local-file-access "output/resume-$theme.html" "$OUT_PDF"
        
        rm "output/resume-$theme.html"
    fi
done

# Fix permissions (since docker runs as root)
chmod 777 output/*
