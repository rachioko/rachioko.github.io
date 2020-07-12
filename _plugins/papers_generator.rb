module Jekyll

  class PaperPage < Page
    def initialize(site, base, dir, papers)
      @site = site
      @base = base
      @dir = dir
      @name = 'index.html'

      self.process(@name)
      self.read_yaml(File.join(base, '_layouts'), 'papers_index.html')
      self.data['papers'] = papers
      self.data['title'] = papers
    end
  end
  
  class PaperPageGenerator < Generator
    safe true

    def generate(site)
      if site.layouts.key? 'papers_index'
        dir = site.config['papers_dir'] || 'papers'
        site.categories.each_key do |papers|
          papers_dir = File.join(dir, Utils.slugify(papers))
          site.pages << PaperPage.new(site, site.source, papers_dir, papers)
        end
      end
    end
  end

end
