import express from 'express';
const router = express.Router();
// all functions underneath controller are now accessible i.e. controller.GetAllArchers()
import * as controller from '../controllers/dataController.js';


router.get('/archers',controller.getAllArchers);
router.get('/rounds', controller.getAllRounds);
router.get('/rounds/:roundID/ranges', controller.getRoundRanges);

router.put('/archers/:id/set-division', controller.setArcherDivision);

router.post('/individual-recorded-rounds', controller.submitRecordedRound);
export default router;  