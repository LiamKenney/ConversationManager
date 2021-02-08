import mServices from "../services/conversationServices";

test("calling getAll returns nonzero entries", async (done) => {
    const response = await mServices.selectAll();
    expect(response.length).toBeGreaterThan(0);
})