#let default-theme = (
  margin: 26pt,
  font: "Libre Baskerville",
  font-size: 8pt,
  font-secondary: "Roboto",
  font-tertiary: "Montserrat",
  text-color: rgb("#3f454d"),
  primary-color: rgb("#c40003"),
  gutter-size: 2em,
  align-gutter: start + top,
  main-width: 6fr,
  aside-width: 3fr,
  profile-picture-width: 55%,
  space-above: 20pt,
  align-title: end,
)


#let theme-state = state("theme", default-theme)

#let set-theme(option) = theme-state.update(current => { current + option })
#let get-theme(option) = {
  assert(option in theme-state.get(), message: "Option not set.")
  theme-state.get().at(option)
}


#let resume(
  first-name: "",
  last-name: "",
  profession: "",
  bio: "",
  profile-picture: none,
  theme: (:),
  aside: [],
  body,
) = {
  theme-state.update(current => {
    current + theme
  })
  theme-state.update(current => {
    if "secondary-color" not in current {
      current + (secondary-color: current.primary-color.lighten(60%))
    } else { current }
  })

  context {
    let theme = theme-state.get()
    set page(
      margin: (
        top: theme.margin,
        bottom: theme.margin,
        left: theme.margin,
        right: theme.margin,
      ),
    )

    // Fix for https://github.com/typst/typst/discussions/2919
    show heading.where(level: 1): set text(size: theme.font-size)
    show heading.where(level: 2): set text(size: theme.font-size)
    show heading.where(level: 3): set text(size: theme.font-size)

    show heading.where(level: 1): set text(font: theme.font-tertiary, weight: "light")

    set text(font: theme.font, size: theme.font-size, fill: theme.text-color)

    set block(above: 10pt, below: 8pt, spacing: 10pt)

    set grid(columns: (theme.gutter-size, 1fr))

    grid(
      columns: (theme.aside-width, theme.margin, theme.main-width),

      // Aside.
      {
        {
          {
            show heading: set block(above: 0pt, below: 0pt)
            show heading: set text(size: 12pt, weight: "regular", font: theme.font, fill: theme.text-color)
            heading(level: 2, first-name)
          }
          {
            show heading: set block(above: 3pt, below: 0pt)
            show heading: set text(size: 26pt, weight: "regular", font: theme.font, fill: theme.text-color)

            heading(level: 1, last-name)
          }
          {
            show heading: set block(above: 10pt, below: 0pt)
            show heading: set text(weight: "light", font: theme.font-tertiary)
            heading(level: 3, upper(profession))
          }

          if profile-picture != none {
            set align(center)

            block(
              width: theme.profile-picture-width,
              above: 1fr,
              below: 1fr,
              layout(size => {
                box(width: size.width, height: size.width, radius: 100%, clip: true, profile-picture)
              }),
            )
          } else {
            v(1fr)
          }


          set text(weight: "light", style: "italic", hyphenate: true)
          set par(leading: 1.0em)
          bio
        }

        aside
      },

      // Empty space.
      { },

      // Content.
      body
    )
  }
}


#let section(
  theme: (:),
  title,
  body,
) = context {
  let theme-before = theme-state.get()

  theme-state.update(current => {
    current + theme
  })

  context {
    let theme = theme-state.get()

    show heading.where(level: 1): set align(theme.align-title)

    v(theme.space-above)


    heading(level: 1, upper(title))
    {
      set block(above: 2pt, below: 14pt)
      line(stroke: 1pt + theme.primary-color, length: 100%)
    }

    body
  }
}

#let timeline-section(theme: (:), title, icon, body) = context {
  let theme-before = theme-state.get()


  theme-state.update(current => {
    current + theme
  })

  context {
    let theme = theme-state.get()

    show heading.where(level: 1): set align(theme.align-title)

    let content = {
      heading(level: 1, upper(title))
      {
        set block(above: 2pt, below: 14pt)
        line(stroke: 1pt + theme.primary-color, length: 100%)
      }
      body
    }

    block(
      stroke: (left: 1pt + theme.primary-color),
      inset: (left: theme.gutter-size),
      {
        content
        place(
          top + left,
          dx: -(theme.gutter-size + 10pt),
          circle(
            radius: 10pt,
            fill: theme.primary-color,
            scale(
              230%,
              {
                set text(size: 5pt, fill: theme.secondary-color)
                align(center + horizon, box(baseline: -40%, icon))
              },
            ),
          ),
        )
      },
    )
    theme-state.update(theme-before)
  }
}

#let contact-entry(
  theme: (:),
  gutter,
  right,
) = context {
  let theme-before = theme-state.get()

  theme-state.update(current => {
    current + theme
  })

  context {
    let theme = theme-state.get()

    set grid(columns: (theme.gutter-size, 1fr))
    set text(font: theme.font-secondary)
    set text(size: theme.font-size)

    grid(
      {
        set align(theme.align-gutter)
        text(fill: black, gutter)
      },
      {
        right
      }
    )
  }
}


#let tech-level(theme: (:), level) = context {
  let theme-before = theme-state.get()

  theme-state.update(current => {
    current + theme
  })

  context {
    let theme = theme-state.get()


    stack(
      dir: ltr,
      spacing: 2pt,
      ..range(5).map(e => {
        circle(
          radius: 4pt,
          stroke: theme.primary-color,
          fill: if e < level { theme.primary-color } else { theme.secondary-color },
        )
      }),
    )
  }
}

#let tech-entry(
  theme: (:),
  tech,
  description,
) = context {
  let theme-before = theme-state.get()

  theme-state.update(current => {
    current + theme
  })
  context {
    let theme = theme-state.get()

    stack(
      dir: ltr,
      tech,
      {
        set align(end)
        set text(fill: theme.primary-color)
        description
      },
    )
  }
}


#let language-entry(
  theme: (:),
  language,
  level,
) = context {
  let theme-before = theme-state.get()

  theme-state.update(current => {
    current + theme
  })

  context {
    let theme = theme-state.get()

    set text(font: theme.font)
    set text(size: theme.font-size)
    stack(
      dir: ltr,
      language,
      {
        set align(end)
        level
      },
    )
  }
}

#let timeline-entry(
  theme: (:),
  timeframe: "",
  title: "",
  organization: "",
  location: "",
  body,
) = context {
  let theme-before = theme-state.get()

  theme-state.update(current => {
    current + theme
  })

  context {
    let theme = theme-state.get()

    set text(size: theme.font-size)

    block(
      above: theme.space-above,
      {
        set text(font: theme.font-secondary)
        show heading: it => {
          place(
            left + horizon,
            dx: -(theme.gutter-size + 3pt),
            circle(radius: 3pt, stroke: theme.primary-color, fill: theme.primary-color),
          )
          text(font: theme.font-secondary, size: theme.font-size, it.body)
        }
        stack(
          dir: ltr,
          spacing: 1fr,
          stack(
            spacing: 5pt,
            {
              set text(weight: "light", fill: text.fill.lighten(30%))
              timeframe
            },
            {
              {
                set text(weight: "bold")
                heading([
                  *#upper(title)* -- #organization
                ])
              }
            },
          ),
          {
            set align(horizon)
            set text(weight: "light", fill: text.fill.lighten(30%))
            location
          },
        )
      },
    )
    {
      set block(above: 6pt, below: 8pt)
      line(stroke: 0.1pt, length: 100%)
    }
    {
      set text(fill: text.fill.lighten(30%))
      set par(leading: 1em)
      body
    }

    theme-state.update(theme-before)
  }
}
