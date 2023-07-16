# Simple Markdown Resume Generator


## What is it?
This repository functions as a tool to turn a markdown formatted document called `resume.md` and turn it into a professionally styled html page that is hosted at this repositories GitHub pages site. This tool also will generate a PDF version of your resume and includes a download link in the rendered webpage.

## How do I use it?

1. For the repo.
The first thing you need to do is fork this repository so you can make your edits and deploy to a pages site.
2. Enable Pages Actions
Navigate to the project settings, and then to the pages settings under code and automation. Under Build and Deployment you should see a drop box that allows you to select the source of your pages deployment. Here you will want to select Github Actions to give actions permissions to deploy to pages. Without setting this the deployment will fail.
3. Edit resume.md with your own content.
This is where you will want to add your own skills, job history, education and such. You can create new sections by using an `h2 ##`. My resume should serve as an example.
4. Edit `.github/workflows/build-and-deploy.yml` with your name.
For now, you will have to edit the workflow file's environment variable to use your name. This is just used to generate the name of the pdf file.
5. Commit and/or Merge changes to main and wait for the workflow to complete.
If all goes well you should have a pages site deployed at `https://${your_github_username}.github.io/resume` and a versioned tag will be created in the repo.

## Can I customize how it looks?
Sure, you can edit the styling by editing `resume-stylesheet.css`. I like a plain look, but feel free to go wild. 


### Credits
Inspried by: https://github.com/vidluther/markdown-resume
