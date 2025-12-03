#!/bin/bash

# Detect architecture for build args (simulating BuildKit's TARGETARCH)
ARCH=$(uname -m)
case $ARCH in
    x86_64)
        TARGETARCH="amd64"
        ;;
    aarch64|arm64)
        TARGETARCH="arm64"
        ;;
    *)
        TARGETARCH="amd64" # Default fallback
        ;;
esac

# 1. Build the image (or pull it if you prefer)
podman build --build-arg TARGETARCH=$TARGETARCH -t resume-local .

# 2. Run the container to generate output
# We mount the current directory to /data in the container
podman run --rm -v $(pwd):/data -w /data resume-local /bin/bash -c "
    mkdir -p output
    
    # Copy all theme CSS files
    cp theme-*.css output/
    
    # Create a temporary markdown file for the HTML site that includes the download link
    cp resume.md resume-site.md
    echo -e \"\\n\\n[Download PDF](resume.pdf)\" >> resume-site.md
    
    # Generate HTML with the default theme (clean) and inject the switcher
    # We use -c theme-clean.css to link it, and --include-before-body to add the switcher
    pandoc resume-site.md -f markdown -t html -c theme-clean.css -s --include-before-body=theme-switcher.html -o output/index.html
    
    # Add ID to the link tag so JS can find it
    sed -i 's/href=\"theme-clean.css\"/href=\"theme-clean.css\" id=\"theme-style\"/' output/index.html
    
    # Cleanup temp markdown
    rm resume-site.md
    
    # Generate PDFs for all themes
    THEMES=('clean' 'modern' 'classic' 'dark' 'terminal' 'bold')
    
    for theme in \"\${THEMES[@]}\"; do
        echo \"Building PDF for theme: \$theme\"
        
        # Create a temp html for this theme
        pandoc resume.md -f markdown -t html -c \"theme-\$theme.css\" -s -o \"output/resume-\$theme.html\"
        
        if [ \"\$theme\" == \"modern\" ]; then
            # Modern theme has color variants
            COLORS=('blue' 'red' 'orange' 'green' 'purple' 'black' 'grey')
            
            for color in \"\${COLORS[@]}\"; do
                echo \"  Building variant: \$theme-\$color\"
                
                # Create a variant HTML with the color class injected
                cp \"output/resume-\$theme.html\" \"output/resume-\$theme-\$color.html\"
                
                # Inject class into body
                # We use a more robust regex to match <body ...> or <body>
                sed -i \"s/<body/<body class=\\\"color-\$color\\\" /\" \"output/resume-\$theme-\$color.html\"
                
                # Determine PDF filename
                if [ \"\$color\" == \"blue\" ]; then
                    OUT_PDF=\"output/resume-\$theme.pdf\"
                else
                    OUT_PDF=\"output/resume-\$theme-\$color.pdf\"
                fi
                
                wkhtmltopdf --page-size Letter --margin-top 0mm --margin-bottom 0mm --margin-left 0mm --margin-right 0mm --enable-local-file-access \"output/resume-\$theme-\$color.html\" \"\$OUT_PDF\"
                
                rm \"output/resume-\$theme-\$color.html\"
            done
            
            # Clean up the base html
            rm \"output/resume-\$theme.html\"
            
        else
            # Standard themes
            if [ \"\$theme\" == \"clean\" ]; then
                OUT_PDF=\"output/resume.pdf\"
            else
                OUT_PDF=\"output/resume-\$theme.pdf\"
            fi
            
            wkhtmltopdf --page-size Letter --margin-top 0mm --margin-bottom 0mm --margin-left 0mm --margin-right 0mm --enable-local-file-access \"output/resume-\$theme.html\" \"\$OUT_PDF\"
            
            rm \"output/resume-\$theme.html\"
        fi
    done
    
    # Fix permissions (since docker runs as root)
    chmod 777 output/*
"

echo "Build complete! Check the 'output' folder."
