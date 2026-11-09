defmodule Jfgenomics.Education do
  def list do
    [
      %{
        title: "Doctor of Philosophy",
        school: "Vanderbilt University",
        area: "Biological Sciences",
        publication:
          "Ortiz, J. F., Rokas, A. (2006). CTDGFinder: A Novel Homology-based Algorithm for identifying Closely Spaced Clusters of Tandemly Duplicated Genes. Molecular Biology and Evolution 34 (1): 215-229",
        pub_link: "https://academic.oup.com/mbe/article/34/1/215/2655122"
      },
      %{
        title: "Master of Science",
        school: "University of Wyoming",
        area: "Molecular Biology",
        publication:
          "Ortiz, J. F., MacDonald, M. L., Masterson, P., Uversky, V. N., Siltberg-Liberles, J. (2013). Rapid Evolutionary Dynamics of Structural Disorder as a Potential Driving Force for Biological Divergence in Flaviviruses. Genome Biology and Evolution 5 (3): 504-513",
        pub_link: "https://doi.org/10.1093/gbe/evt026"
      },
      %{
        title: "Bachelor of Science",
        school: "Universidad Nacional de Colombia",
        area: "Biology",
        publication:
          "Ortiz, J. F., Gavio, B. (2010). Notes on the marine algae of the International Biosphere Reserve Seaflower, Caribbean Colombia II: diversity of drift algae in San Andres island, Caribbean Colombia. Caribbean Journal of Science 46 (2-3): 313-321",
        pub_link: "https://doi.org/10.18475/cjos.v46i2.a19"
      }
    ]
  end
end
