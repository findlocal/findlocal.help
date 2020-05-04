import "js-autocomplete/auto-complete.css"
import autocomplete from "js-autocomplete"
const autocompleteSearchNew = function () {
  const s = document.getElementById("search-data_new")
  // console.log(s)
  const skills = JSON.parse(
    document.getElementById("search-data-new").dataset.skills
  )
  const searchInput = document.getElementById("search_new")
  if (skills && searchInput) {
    new autocomplete({
      selector: searchInput,
      minChars: 1,
      source: function (term, suggest) {
        term = term.toLowerCase()
        const choices = skills
        const matches = []
        for (let i = 0; i < choices.length; i++)
          if (~choices[i].toLowerCase().indexOf(term)) matches.push(choices[i])
        suggest(matches)
      },
    })
  }
}
export { autocompleteSearchNew }
