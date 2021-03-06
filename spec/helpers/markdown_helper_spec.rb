require 'spec_helper'

describe MarkdownHelper do
  describe '#render_markdown' do
    it 'renders markdown' do
      expect(helper.render_markdown('# Test')).to match(/h1/)
    end

    it 'renders fenced code blocks' do
      codeblock = <<-EOH
```sh
$ bundle exec rake spec:all
```
      EOH

      expect(helper.render_markdown(codeblock)).to match(/<pre><code class="sh">/)
    end

    it 'auto renders links with target blank' do
      expect(helper.render_markdown('http://getchef.com')).
        to match(Regexp.quote('<a href="http://getchef.com" target="_blank">http://getchef.com</a>'))
    end
  end

  it 'renders tables' do
    table = <<-EOH
| name | version |
| ---- | ------- |
| apt  | 0.25    |
| yum  | 0.75    |
    EOH

    expect(helper.render_markdown(table)).to match(/<table>/)
  end

  it 'adds br tags on hard wraps' do
    markdown = <<-EOH
This is a hard
wrap.
    EOH

    expect(helper.render_markdown(markdown)).to match(/<br>/)
  end

  it "doesn't emphasize underscored words" do
    expect(helper.render_markdown('some_long_method_name')).to_not match(/<em>/)
  end

  it 'adds HTML anchors to headers' do
    expect(helper.render_markdown('# Tests')).to match(/id="tests"/)
  end

  it 'strikesthrough text using ~~ with a del tag' do
    expect(helper.render_markdown('~~Ignore This~~')).to match(/<del>/)
  end

  it 'superscripts text using ^ with a sup tag' do
    expect(helper.render_markdown('Supermarket^2')).to match(/<sup>/)
  end
end
