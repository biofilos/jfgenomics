defmodule Jfgenomics.Experience do
  def list do
    [
      %{
        "country" => "Singapore",
        "dates" => "September 2025 - present",
        "description" => [
          "Accelerate the discovery rate of the R+D team by designing and implementing cutting-edge web applications to streamline bioinformatics analyses",
          "Improve the organization's data posture by developing novel algorithms to data-mine multi-omics and comparative genomics data.",
          "Support scientific collaborations with state-of-the-art NGS (scRNA-seq, RNA-seq, et al.) primary and downstream analyses"
        ],
        "place" => "Paratus Sciences",
        "title" => "Senior Computational Biology"
      },
      %{
        "country" => "Singapore",
        "dates" => "January 2024 - September 2025",
        "description" => [
          "Translate stakeholders biological questions into scalable code and cloud computational infrastructure",
          "Troubleshoot technical issues that users have when running nextflow pipelines",
          "Design and implement novel solutions to improve the user journey on the platform",
          "Design and implement tools and infrastructure to improve the developer experience of colleagues"
        ],
        "place" => "Lifebit",
        "title" => "Senior Bioinformatician I"
      },
      %{
        "country" => "Singapore",
        "dates" => "February 2022 - January 2024",
        "description" => [
          "Design cloud-native (AWS) architecture for deploying and running scalable NGS workflows",
          "Encode scalable and optimized NGS workflows using the WDL language",
          "Design full-stack web application for submitting and tracking NGS workflows",
          "Design and execute research projects and collaborative initiatives in NGS science"
        ],
        "place" =>
          "Genomics and Data Analytics Core, Cancer Sciences Institute, National University of Singapore",
        "title" => "Lead Bioinformatic Engineer"
      },
      %{
        "country" => "Japan",
        "dates" => "April 2020 - February 2022",
        "description" => [
          "Develop algorithms for the assessment of novel chromatin conformation capture experiments",
          "Design and execute research projects on comparative chromatin dynamics and their association with ageing"
        ],
        "place" => "RIKEN Center for Integrative Medical Sciences",
        "title" => "Special Postdoctoral Fellow"
      },
      %{
        "country" => "Japan",
        "dates" => "May 2019 - April 2020",
        "description" => [
          "Develop data analysis pipelines and downstream analysis for RNA-seq experiments",
          "Design and execute research programs combining structural genomics and evolutionary biology methods",
          "Deploy a genome browser integrating multi-omics data for the brownbanded bamboo shark genome"
        ],
        "place" => "RIKEN Biosystems Dynamics Research",
        "title" => "Postdoctoral fellow"
      }
    ]
  end
end
