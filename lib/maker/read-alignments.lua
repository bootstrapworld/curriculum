local make_dir = 'lib/maker/'

dofile(make_dir .. 'utils.lua')
dofile(make_dir .. 'readers.lua')
dofile(make_dir .. 'jread.lua')

local function read_alignment_file(nickname, expanded_name, f, url)
  -- print('doing read_alignment_file', nickname, expanded_name, f, url)
  return {
    nickname,
    expanded_name,
    read_json_file('shared/langs/en-us/' .. f),
    url
  }
end

standards_list = {
  read_alignment_file('CCSS-Math', 'Common Core Math', 'standards/standards-cc-math-dictionary.json', 'http://corestandards.org/Math/'),
  read_alignment_file('CC-ELA', 'Common Core ELA', 'standards/standards-cc-ela-dictionary.json', 'http://corestandards.org/ELA-Literacy/'),
  read_alignment_file('CSTA', 'CSTA', 'standards/standards-csta-dictionary.json', 'https://csteachers.org/page/'),
  read_alignment_file('K12CS', 'K-12CS', 'standards/standards-k12cs-dictionary.json', 'https://k12cs.org'),
  read_alignment_file('NGSS', 'Next-Gen Science', 'standards/standards-ngss-dictionary.json', 'https://www.nextgenscience.org/'),
  read_alignment_file('IA', 'Iowa', 'standards/standards-ia-dictionary.json', 'https://iowacore.gov/standards/iowa-core-standards'),
  read_alignment_file('MA', 'Massachusetts', 'standards/standards-ma-dictionary.json', 'https://www.doe.mass.edu/frameworks/'),
  read_alignment_file('OK', 'Oklahoma', 'standards/standards-ok-dictionary.json', 'https://sde.ok.gov/okhahome-academic-standards'),
  read_alignment_file('OR', 'Oregon', 'standards/standards-or-dictionary.json', 'https://www.oregon.gov/ode/educator-resources/standards/pages/default.aspx'),
  read_alignment_file('TX', 'Texas', 'standards/standards-tx-dictionary.json', 'https://www.oregon.gov/ode/educator-resources/standards/pages/default.aspx'),
}

textbooks_list = {
  read_alignment_file('CMP', 'Connected Math', 'textbooks/textbook-cmp-dictionary.json', 'https://connectedmath.msu.edu/'),
  read_alignment_file('IM.6', 'IM 6 Math', 'textbooks/textbook-im-6-dictionary.json', 'https://illustrativemathematics.org/'),
  read_alignment_file('IM.7', 'IM 7 Math', 'textbooks/textbook-im-7-dictionary.json', 'https://illustrativemathematics.org/'),
  read_alignment_file('IM.8', 'IM 8 Math', 'textbooks/textbook-im-8-dictionary.json', 'https://illustrativemathematics.org/'),
  read_alignment_file('IM.Alg.1', 'IM Algebra 1', 'textbooks/textbook-im-alg-1-dictionary.json', 'https://illustrativemathematics.org/'),
}

practices_list = {
  -- read_alignment_file('MLR', 'Math Lang. Routines', 'practices/practices-mlr-dictionary.json', 'https://achievethecore.org/peersandpedagogy/developing-math-language-routines/'),
  read_alignment_file('SPLC', 'Social Justice', 'practices/practices-sj-dictionary.json',          'https://www.learningforjustice.org/sites/default/files/2017-06/TT_Social_Justice_Standards_0.pdf' ),
  read_alignment_file('NGSS', 'Science and Engineering', 'practices/practices-sep-dictionary.json', 'https://ngss.nsta.org/practicesfull.aspx' ),
  read_alignment_file('CCSS', 'Common Core Math', 'practices/practices-cc-dictionary.json',  'http://corestandards.org/Math/'),
  read_alignment_file('K12CS', 'K12CS', 'practices/practices-k12cs-dictionary.json', 'https://k12cs.org' ),
}
