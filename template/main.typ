#import "@preview/nerd-icons:0.2.0": nf-icon
#import "../package.typ": *

// To learn about theming, see https://github.com/tsnobip/typst-typographic-resume?tab=readme-ov-file#theme
// make sure you have installed the fonts you want to use
#show: resume.with(
  theme: (
    gutter-size: 4em,
    space-above: 20pt,
    primary-color: blue,
  ),
  first-name: "Paul",
  last-name: "Dupont",
  profession: "Software Engineer",
  bio: [
    Experienced software engineer with a passion for developing innovative programs that expedite the efficiency and effectiveness of organizational success.],
  profile-picture: image(fit: "contain", "../images/profile_pic_example.jpg"),
  aside: {
    section(
      "Contact",
      {
        contact-entry(
          nf-icon("nf-md-github"),
          link("https://github.com/pauldupont/", "pauldupont"),
        )
        line(stroke: 0.1pt, length: 100%)
        contact-entry(
          nf-icon("nf-fa-phone"),
          link("tel:+33 6 78 90 12 34", "+33 6 78 90 12 34"),
        )
        line(stroke: 0.1pt, length: 100%)
        contact-entry(
          nf-icon("nf-md-email"),
          link("mailto:pauldupont@example.com", "pauldupont@example.com"),
        )
      },
    )

    section(
      "Projects and Contributions",
      {
        set text(font: "Roboto", size: 8pt)
        stack(
          spacing: 8pt,
          tech-entry(link("https://github.com/tuxerator/burp", "tuxerator/burp"), "Bachelor Thesis"),
          tech-entry(link("https://github.com/Maximkaaa/galileo/pull/86", "Maximkaaa/galileo"), "fixed a small bug"),
          tech-entry(
            link("https://github.com/tuxerator/software-project-hammerzon", "tuxerator/hammerzon"),
            "small web store",
          ),
        )
      },
    )

    section(
      "Tech Stack",
      {
        set text(font: "Roboto", size: 8pt)
        stack(
          spacing: 8pt,
          tech-entry("JavaScript", "It's JavaScript what do you expect"),
          tech-entry("ReScript", tech-level(3)),
          tech-entry("React", 5),
          tech-entry("Node.js", 4),
          tech-entry("Django", 2),
          tech-entry("PostgreSQL", 2),
          tech-entry("Docker", 4),
          tech-entry("Kubernetes", 3),
        )
      },
    )

    section(
      "Languages",
      {
        language-entry("English", "Native")
        language-entry("Spanish", "Fluent")
        language-entry("German", "Intermediate")
      },
    )

    section(
      "Interests",
      {
        set text(size: 7pt)
        stack(
          spacing: 8pt,
          "Open Source Contributions",
          "Road biking",
          "Traveling",
        )
      },
    )
  },
)


#block(
  height: 1fr,
  timeline-section(
    theme: (space-above: 1fr),
    "Work Experiences",
    nf-icon("nf-fa-briefcase"),
    {
      timeline-entry(
        theme: (space-above: 10pt),
        timeframe: "Jan 2024 - Today",
        title: "Senior Software Engineer",
        organization: "Tech Innovators Inc.",
        location: "Lyon, FR",
        [
          Led a team of developers to design and implement scalable web applications.
          Improved system performance by 30% through code optimization.
          Mentored junior developers, fostering a culture of continuous learning.
          Spearheaded the migration of legacy systems to modern cloud-based infrastructure.
        ],
      )
      timeline-entry(
        timeframe: "Oct 2020 - December 2023",
        title: "Software Engineer",
        organization: "CodeCraft Solutions",
        location: "San Francisco, USA",
        [
          Developed and maintained RESTful APIs for client applications.
          Collaborated with cross-functional teams to deliver high-quality software.
          Implemented CI/CD pipelines, reducing deployment times by 40%.
          Conducted code reviews to ensure adherence to best practices and coding standards.
        ],
      )
      timeline-entry(
        timeframe: "Jul 2019 - Oct 2020",
        title: "Junior Software Engineer",
        organization: "NextGen Tech",
        location: "Tbilisi, GE",
        [
          Assisted in the development of e-commerce platforms.
          Wrote unit tests to ensure code reliability and maintainability.
          Participated in agile ceremonies, contributing to sprint planning and retrospectives.
          Researched and implemented new tools to improve development workflows.
        ],
      )
      timeline-entry(
        timeframe: "Nov 2018 - Jun 2019",
        title: "Intern",
        organization: "Startup Hub",
        location: "Paris, FR",
        [
          Supported the development team in debugging and testing applications.
          Gained hands-on experience with modern web technologies.
          Created technical documentation for internal tools and processes.
          Assisted in the deployment of a new customer-facing web application.
        ],
      )
      timeline-entry(
        timeframe: "Jun 2017 - Oct 2018",
        title: "Freelance Developer",
        organization: "Self-Employed",
        location: "Remote",
        [
          Designed and developed custom websites for small businesses.
          Provided technical support and maintenance for client projects.
          Built responsive and user-friendly interfaces using modern web technologies.
          Managed multiple projects simultaneously, ensuring timely delivery.
        ],
      )
      timeline-entry(
        timeframe: "Jan 2016 - May 2017",
        title: "Research Assistant",
        organization: "École des Mines de St-Étienne",
        location: "St-Étienne, France",
        [
          Conducted research on algorithms for optimizing large-scale systems.
          Published findings in peer-reviewed journals and presented at conferences.
          Developed prototypes to validate research concepts.
          Collaborated with a multidisciplinary team to achieve project goals.
        ],
      )
    },
  ),
)
#block(
  height: auto,
  timeline-section(
    "Education",
    nf-icon("graduation_cap"),
    {
      timeline-entry(
        title: "MSc in Computer Science",
        organization: "École des Mines de St-Étienne",
        timeframe: "2014 - 2017",
        location: "St-Étienne, France",
        [Focused on software engineering, algorithms, and data structures.],
      )
      timeline-entry(
        title: "PhD in Artificial Intelligence",
        organization: "Seoul National University",
        timeframe: "2017 - 2021",
        location: "Seoul, South Korea",
        [Specialized in machine learning and natural language processing.],
      )
    },
  ),
)
