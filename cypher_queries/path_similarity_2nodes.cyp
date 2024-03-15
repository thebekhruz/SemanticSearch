MATCH (doc1:Document)-[:refers_to]->(r1)
        WHERE doc1.doc_id = '6d745c24-5df5-3fc6-b838-a7be923e6499'
        MATCH (doc2:Document)-[:refers_to]->(r2)
        WHERE doc2.doc_id = '196c11e6-f7b6-392f-ae41-28653345087c'
        // return n10s.sim.pathsim.value(r1, r2, { simulateRoot:false }) as sim, [n in nodes(n10s.sim.pathsim.path(r1, r2, { simulateRoot: false})) | n.label] AS value
        return *, n10s.sim.pathsim.path(r1,r2, { simulateRoot:false })