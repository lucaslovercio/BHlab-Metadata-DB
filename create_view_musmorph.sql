CREATE OR REPLACE VIEW MusMorph_View AS
SELECT Biosample.Biosample, Biosample.Species, Biosample.Dataset_Origin, Biosample.Treatment, Biosample.Experimental_Group, Biosample.Sex, Biosample_Strain.Strain, Strain.Strain_MGI_ID, Strain.Strain_Type, Stage.Stage, Stage.Life_Phase, Has_Genotype.Gene, Has_Genotype.Genotype, Has_Genotype.Zygosity, Gene.Gene_MGI_ID, Biosample_Prepared.Protocol, Biosample_Prepared.Anatomy, Scan.Scanner, Scan.Availability
FROM (((((((Biosample
INNER JOIN Biosample_Strain ON Biosample.Biosample = Biosample_Strain.Strain)
INNER JOIN Strain ON Biosample_Strain.Strain = Strain.Strain)
INNER JOIN Stage ON Biosample.Stage = Stage.Stage)
INNER JOIN Has_Genotype ON Biosample.Biosample = Has_Genotype.Biosample)
INNER JOIN Gene ON Has_Genotype.Gene = Gene.Gene)
INNER JOIN Biosample_Prepared ON Biosample.Biosample = Biosample_Prepared.Biosample)
INNER JOIN Scan ON Biosample_Prepared.Protocol = Scan.Protocol AND Biosample_Prepared.Anatomy = Scan.Anatomy);