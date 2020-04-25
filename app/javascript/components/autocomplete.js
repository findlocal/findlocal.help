import autocomplete from 'js-autocomplete';
const autocompleteSearch = function() {
  console.log('test')
  const s = document.getElementById('search-data')
  console.log(s)
  const skills = JSON.parse(document.getElementById('search-data').dataset.skills)
  const searchInput = document.getElementById('search_');
  if (skills && searchInput) {
    new autocomplete({
      selector: searchInput,
      minChars: 1,
      source: function(term, suggest){
          term = term.toLowerCase();
          const choices = skills;
          const matches = [];
          for (let i = 0; i < choices.length; i++)
              if (~choices[i].toLowerCase().indexOf(term)) matches.push(choices[i]);
          suggest(matches);
      },
    });
  }
};
export { autocompleteSearch };