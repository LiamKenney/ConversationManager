import cServices from "../services/conversationServices";

test("calling getAll returns nonzero entries", async (done) => {
    const response = await cServices.selectAll();
    expect(response.length).toBeGreaterThan(0);
})