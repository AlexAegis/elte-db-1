SELECT DOLGOZO.DNEV AS "Dolgoz� N�v", OSZTALY.ONEV AS "Oszt�ly N�v"
FROM DOLGOZO
JOIN OSZTALY ON DOLGOZO.OAZON = OSZTALY.OAZON;
