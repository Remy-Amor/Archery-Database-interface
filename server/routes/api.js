import express from 'express';
const router = express.Router();
// all functions underneath controller are now accessible i.e. controller.GetAllArchers()
import * as controller from '../controllers/dataController.js';


router.get('/archers',controller.getAllArchers);
router.get('/rounds', controller.getAllRounds);
router.put('/archers/:id/set-division', controller.setArcherDivision);
export default router;  